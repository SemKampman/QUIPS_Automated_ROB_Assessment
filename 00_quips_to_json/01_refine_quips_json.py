#!/usr/bin/env python3
#
# 2 Jan 2026 (w.m.otte@umutrecht.nl)
#
# Fine-tune the converted json (QUIPS).
#

import json
import re

input_path = 'quips_tool.json'
output_path = 'quips_tool_clean.json'

with open(input_path, 'r') as f:
    raw_data = json.load(f)

raw_rows = raw_data['raw_rows']

options_reporting = ["Yes", "Partial", "No", "Unsure"]
options_risk = ["High", "Moderate", "Low"]

clean_tool = {
    "tool_metadata": {
        "title": raw_rows[0][0]['text'],
        "source": raw_rows[1][0]['text'],
        "instructions": {
             "general": "Provide comments or text exerpts in the white boxes below, as necessary, to facilitate the consensus process that will follow.",
             "reporting": "Click on each of the blue cells and choose from the drop down menu to rate the adequacy of reporting as yes, partial, no or unsure.",
             "risk_of_bias": "Click on the green cells; choose from the drop-down menu to rate potential risk of bias for each of the 6 domains as High, Moderate, or Low considering all relevant issues"
        }
    },
    "domains": []
}

current_domain = None
domain_header_re = re.compile(r"^(\d+)\.\s+(.*)")

for row in raw_rows:
    if not row:
        continue
        
    first_cell = row[0]
    first_text = first_cell.get('text', '').strip() if first_cell.get('text') else ''
    first_coord = first_cell['coordinate']
    
    # Check for domain header (Always in Column A)
    if first_coord.startswith('A') and domain_header_re.match(first_text):
        match = domain_header_re.match(first_text)
        domain_num = int(match.group(1))
        domain_name = match.group(2)
        
        goal = ""
        # Goal is usually in the next cell (B)
        if len(row) > 1 and row[1]['coordinate'].startswith('B'):
            goal = row[1]['text']
            
        current_domain = {
            "domain_number": domain_num,
            "domain_name": domain_name,
            "goal": goal,
            "items": [],
            "risk_of_bias_assessment": None
        }
        clean_tool['domains'].append(current_domain)
        continue
    
    if current_domain:
        # Check if it is the summary row (Always in Column A)
        if first_coord.startswith('A') and "Summary" in first_text:
            prompt = ""
            if len(row) > 1 and row[1]['coordinate'].startswith('B'):
                prompt = row[1]['text']
            
            current_domain['risk_of_bias_assessment'] = {
                "label": first_text,
                "prompt": prompt,
                "response_options": options_risk
            }
        else:
            # It's an item.
            # Case 1: Label in A, Prompt in B
            if first_coord.startswith('A'):
                label = first_text
                prompt = ""
                # Find prompt in B
                for cell in row:
                    if cell['coordinate'].startswith('B'):
                        prompt = cell['text']
                        break
                
                # If we found a prompt (or at least a B cell which might be the prompt)
                # But we must ensure it's not a header or random text.
                # Assuming if it has a label in A and text in B, it's an item.
                # Use dropdown existence as a strong signal?
                # The raw items usually have a dropdown in D (reporting) or E (summary, handled above).
                
                has_dropdown = any('dropdown_options' in cell for cell in row)
                if has_dropdown or (label and prompt):
                     item = {
                        "label": label,
                        "prompt": prompt,
                        "response_options": options_reporting
                    }
                     current_domain['items'].append(item)

            # Case 2: No Label in A (so first cell is B), Prompt in B
            elif first_coord.startswith('B'):
                label = "" # No label for this sub-item
                prompt = first_text
                
                item = {
                    "label": label,
                    "prompt": prompt,
                    "response_options": options_reporting
                }
                current_domain['items'].append(item)

with open(output_path, 'w') as f:
    json.dump(clean_tool, f, indent=2)

print(f"Cleaned JSON written to {output_path}")
