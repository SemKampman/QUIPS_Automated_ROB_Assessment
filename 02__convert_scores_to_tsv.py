#!/usr/bin/env python3
#
# 2 Jan 2026 (w.m.otte@umcutrecht.nl)
#
# Converts structured QUIPS JSON outputs into a flat TSV file for R.
#
#############################################

import os
import json
import csv
import glob
from typing import List, Dict, Any

# --- Configuration ---
SCHEMA_FILE = "misc/QUIPS_tool.json"

# Intuitive Column Mapping
COLUMN_MAPPING = {
    # D1: Participation
    "D1_I1": "D1_Source",
    "D1_I2": "D1_Method",
    "D1_I3": "D1_Period",
    "D1_I4": "D1_Place",
    "D1_I5": "D1_Criteria",
    "D1_I6": "D1_Participation",
    "D1_I7": "D1_Baseline",
    
    # D2: Attrition
    "D2_I1": "D2_Response",
    "D2_I2": "D2_Attempts",
    "D2_I3": "D2_Reasons",
    "D2_I4": "D2_DropoutChar",
    "D2_I5": "D2_Diff",
    
    # D3: PF Measurement
    "D3_I1": "D3_Def",
    "D3_I2": "D3_Validity",
    "D3_I3": "D3_Continuous",
    "D3_I4": "D3_Method",
    "D3_I5": "D3_Proportion",
    "D3_I6": "D3_Imputation",
    
    # D4: Outcome Measurement
    "D4_I1": "D4_Def",
    "D4_I2": "D4_Validity",
    "D4_I3": "D4_Method",
    
    # D5: Confounding
    "D5_I1": "D5_Measured",
    "D5_I2": "D5_Def",
    "D5_I3": "D5_Validity",
    "D5_I4": "D5_Method",
    "D5_I5": "D5_Imputation",
    "D5_I6": "D5_Design",
    "D5_I7": "D5_Analysis",
    
    # D6: Analysis
    "D6_I1": "D6_Presentation",
    "D6_I2": "D6_ModelBuild",
    "D6_I3": "D6_ModelSelect",
    "D6_I4": "D6_Reporting"
}

def load_schema_structure(schema_path: str) -> List[str]:
    """
    Reads the QUIPS tool schema to generate the canonical list of column headers
    using the intuitive mapping.
    """
    if not os.path.exists(schema_path):
        print(f"Warning: Schema file not found at {schema_path}. Column ordering might be less predictable.")
        return []

    try:
        with open(schema_path, 'r', encoding='utf-8') as f:
            schema = json.load(f)
    except Exception as e:
        print(f"Error loading schema: {e}")
        return []

    headers = []
    
    # Iterate through domains in order
    for domain in schema.get('domains', []):
        d_num = domain.get('domain_number')
        prefix = f"D{d_num}"
        
        # Domain Level Headers
        headers.append(f"{prefix}_Risk")
        headers.append(f"{prefix}_Risk_Reasoning")
        
        # Item Level Headers
        for i, item in enumerate(domain.get('items', []), 1):
            i_prefix = f"{prefix}_I{i}"
            col_base = COLUMN_MAPPING.get(i_prefix, i_prefix) # Fallback to code if mapping missing
            
            headers.append(f"{col_base}_Rating")
            headers.append(f"{col_base}_Evidence")
            headers.append(f"{col_base}_Reasoning")
            
    return headers

def flatten_quips_json(file_path: str, data: Dict[str, Any]) -> Dict[str, str]:
    """
    Flattens a hierarchical QUIPS JSON object into a single dictionary row.
    """
    row = {}
    
    # 1. Metadata
    meta = data.get('paper_metadata', {})
    row['filename'] = os.path.basename(file_path)
    row['first_author'] = meta.get('first_author', 'NA')
    row['year'] = meta.get('year', 'NA')
    row['title'] = meta.get('title', 'NA')
    
    # 2. Domains
    # Create a lookup for the domain data to access by domain number
    domain_map = {d.get('domain_number'): d for d in data.get('quips_assessment', [])}

    # Iterate through all expected items defined in the mapping
    # We group by domain to handle the Risk/Risk_Reasoning headers efficiently
    # But a simpler approach for this script is to iterate the mapping keys which are roughly sorted.
    
    # Actually, we need to respect the SCHEMA order.
    # Let's rely on the schema structure to drive the row population, similar to how we drive headers.
    
    # Re-load schema to drive the iteration order
    try:
        with open(SCHEMA_FILE, 'r', encoding='utf-8') as f:
            schema = json.load(f)
            
        for domain_def in schema.get('domains', []):
            d_num = domain_def.get('domain_number')
            prefix = f"D{d_num}"
            
            # Get the actual data for this domain
            domain_data = domain_map.get(d_num, {})
            
            # Domain Level
            row[f"{prefix}_Risk"] = domain_data.get('risk_of_bias', 'NA')
            row[f"{prefix}_Risk_Reasoning"] = domain_data.get('risk_reasoning', 'NA').replace('\n', ' ').replace('\t', ' ')
            
            # Items
            # Create a lookup for items by their label or index? 
            # The JSON output usually is an array. We assume order matches schema.
            # Safety: Map items by label or just trust index? Trusting index is risky if model skips.
            # Best effort: Map items by index since we asked model to follow schema.
            items_data_list = domain_data.get('items', [])
            
            # Pre-fill with NA based on schema definition
            for i, item_def in enumerate(domain_def.get('items', []), 1):
                i_prefix = f"{prefix}_I{i}"
                col_base = COLUMN_MAPPING.get(i_prefix, i_prefix)
                
                # Try to find corresponding item in data
                # We assume the model returned items in order.
                item_data = {}
                if i <= len(items_data_list):
                    item_data = items_data_list[i-1]
                
                row[f"{col_base}_Rating"] = item_data.get('rating', 'NA')
                
                evidence = item_data.get('evidence_snippet', 'NA')
                if evidence is None: evidence = "NA"
                row[f"{col_base}_Evidence"] = str(evidence).replace('\n', ' ').replace('\t', ' ')
                
                reasoning = item_data.get('reasoning', 'NA')
                if reasoning is None: reasoning = "NA"
                row[f"{col_base}_Reasoning"] = str(reasoning).replace('\n', ' ').replace('\t', ' ')
                
    except Exception as e:
        print(f"Error populating row from schema: {e}")
        return {}

    return row

def main():
    # 1. Interactive Inputs
    default_input = "outputs/1_Giuliano_2021"
    default_output = "outputs/1_Giuliano_2021/quips_summary.tsv"
    
    input_dir = input(f"Enter input directory containing JSON files [{default_input}]: ").strip() or default_input
    output_file = input(f"Enter output TSV file path [{default_output}]: ").strip() or default_output
    
    # Ensure output directory exists
    output_dir = os.path.dirname(output_file)
    if output_dir:
        os.makedirs(output_dir, exist_ok=True)
    
    # 2. Build Headers
    # Base metadata headers
    fieldnames = ['filename', 'first_author', 'year', 'title']
    
    # Dynamic headers from schema
    schema_headers = load_schema_structure(SCHEMA_FILE)
    if schema_headers:
        fieldnames.extend(schema_headers)
    else:
        # Fallback if schema fails: we'll have to rely on the first file or just dynamic addition (not ideal for csv dictwriter)
        print("Using simplified header generation due to missing schema.")
        # This part is a backup, usually schema should load.
        pass

    rows = []
    
    # 3. Process Files
    json_files = glob.glob(os.path.join(input_dir, "*.json"))
    if not json_files:
        print(f"No JSON files found in {input_dir}")
        return

    print(f"Found {len(json_files)} files. Processing...")
    
    for jf in json_files:
        try:
            with open(jf, 'r', encoding='utf-8') as f:
                data = json.load(f)
                flat_row = flatten_quips_json(jf, data)
                rows.append(flat_row)
        except Exception as e:
            print(f"Error processing {jf}: {e}")

    # 4. Write TSV
    try:
        with open(output_file, 'w', encoding='utf-8', newline='') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames, delimiter='\t', extrasaction='ignore')
            writer.writeheader()
            writer.writerows(rows)
        print(f"Successfully wrote {len(rows)} rows to {output_file}")
    except Exception as e:
        print(f"Error writing output file: {e}")

if __name__ == "__main__":
    main()
