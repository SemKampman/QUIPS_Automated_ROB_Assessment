#!/usr/bin/env python3
#
# 1 Jan 2026 (w.m.otte@umcutrecht.nl)
#
#############################################

import os
import json
import time
import glob
from datetime import datetime
from dotenv import load_dotenv
from openai import OpenAI

# --- Configuration ---
load_dotenv() # Load environment variables from .env
# Uses OpenRouter compatible endpoint
MODEL_NAME = "google/gemini-3-flash-preview" 
OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")
PROMPT_FILE = "prompts/quips_assessment.md"

# Interactive directory selection
DEFAULT_INPUT = "data_md_converted/1_Giuliano_2021"
DEFAULT_OUTPUT = "outputs/1_Giuliano_2021"

INPUT_DIR = input(f"Enter input directory [{DEFAULT_INPUT}]: ").strip() or DEFAULT_INPUT
OUTPUT_DIR = input(f"Enter output directory [{DEFAULT_OUTPUT}]: ").strip() or DEFAULT_OUTPUT

if not OPENROUTER_API_KEY:
    print("Error: OPENROUTER_API_KEY environment variable not set.")
    exit(1)

# Ensure output directory exists
os.makedirs(OUTPUT_DIR, exist_ok=True)

client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key=OPENROUTER_API_KEY,
)

def read_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        return f.read()

def save_json(data, filename):
    filepath = os.path.join(OUTPUT_DIR, filename)
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
    # 1. Load System Prompt
    if not os.path.exists(PROMPT_FILE):
        print(f"Error: Prompt file not found at {PROMPT_FILE}")
        return
    
    prompt_template = read_file(PROMPT_FILE)
    print(f"Loaded prompt from {PROMPT_FILE}")

    # 2. Find MD files
    md_files = glob.glob(os.path.join(INPUT_DIR, "*.md"))
    if not md_files:
        print(f"No markdown files found in {INPUT_DIR}")
        return

    print(f"Found {len(md_files)} papers to process.")

    # 3. Process each file
    for file_path in md_files:
        filename = os.path.basename(file_path)
        base_name = os.path.splitext(filename)[0]
        output_filename = f"scoring_{base_name}.json"
        output_filepath = os.path.join(OUTPUT_DIR, output_filename)

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
            
            save_json(result_json, output_filename)
        else:
            print(f"Failed to generate JSON for {filename}")
            
        # Rate limit pause just in case
        time.sleep(1)

if __name__ == "__main__":
    main()
