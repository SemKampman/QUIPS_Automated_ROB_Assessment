#!/usr/bin/env python3
#
# 1 Jan 2026 (w.m.otte@umcutrecht.nl)
#
#############################################

import os
import json
import time
import glob
import argparse
from datetime import datetime
from dotenv import load_dotenv
from openai import OpenAI

# --- Configuration ---
load_dotenv() # Load environment variables from .env
# Uses OpenRouter compatible endpoint
MODEL_NAME = "google/gemini-3-flash-preview" 
OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")
PROMPT_FILE = "prompts/quips_assessment.md"

if not OPENROUTER_API_KEY:
    print("Error: OPENROUTER_API_KEY environment variable not set.")
    exit(1)

client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key=OPENROUTER_API_KEY,
)

def read_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        return f.read()

def save_json(data, filename, output_dir):
    filepath = os.path.join(output_dir, filename)
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
    print(f"Saved: {filepath}")

def process_paper(md_content, prompt_template):
    messages = [
        {"role": "system", "content": prompt_template},
        {"role": "user", "content": f"Here is the clinical paper content:\n\n{md_content}"}
    ]

    try:
        completion = client.chat.completions.create(
            model=MODEL_NAME,
            messages=messages,
            response_format={"type": "json_object"}, # Force JSON if supported by provider/model
            temperature=0.0
        )
        
        response_content = completion.choices[0].message.content
        return json.loads(response_content)
    except Exception as e:
        print(f"Error processing LLM request: {e}")
        return None

def main():
    parser = argparse.ArgumentParser(
        description="Run QUIPS scoring on markdown files. Example: python 01__run_quips_scoring.py -i data_md_converted/1_Giuliano_2021 -o outputs/1_Giuliano_2021"
    )
    parser.add_argument("-i", "--input", required=True, help="Input directory containing .md files")
    parser.add_argument("-o", "--output", required=True, help="Output directory for .json files")
    args = parser.parse_args()

    # Ensure output directory exists
    os.makedirs(args.output, exist_ok=True)

    # 1. Load System Prompt
    if not os.path.exists(PROMPT_FILE):
        print(f"Error: Prompt file not found at {PROMPT_FILE}")
        return
    
    prompt_template = read_file(PROMPT_FILE)
    print(f"Loaded prompt from {PROMPT_FILE}")

    # 2. Find MD files
    md_files = glob.glob(os.path.join(args.input, "*.md"))
    if not md_files:
        print(f"No markdown files found in {args.input}")
        return

    print(f"Found {len(md_files)} papers to process.")

    # 3. Process each file
    for file_path in md_files:
        filename = os.path.basename(file_path)
        base_name = os.path.splitext(filename)[0]
        output_filename = f"scoring_{base_name}.json"
        output_filepath = os.path.join(args.output, output_filename)

        print(f"\nProcessing: {filename}...")

        if os.path.exists(output_filepath):
            print(f"Skipping (already exists): {output_filename}")
            continue
        
        md_content = read_file(file_path)
        
        # Skip if empty or too short
        if len(md_content) < 100:
            print("Skipping (content too short).")
            continue

        result_json = process_paper(md_content, prompt_template)
        
        if result_json:
            # Add processing metadata
            result_json['processing_metadata'] = {
                "source_file": file_path,
                "model": MODEL_NAME,
                "processed_at": datetime.now().isoformat()
            }
            
            save_json(result_json, output_filename, args.output)
        else:
            print(f"Failed to generate JSON for {filename}")
            
        # Rate limit pause just in case
        time.sleep(1)

if __name__ == "__main__":
    main()
