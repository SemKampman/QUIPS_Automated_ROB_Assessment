#!/usr/bin/env python3
#
# 2 Jan 2026 (w.m.otte@umcutrecht.nl)
# Convert the Excelsheet (QUIPS) into json format.
#
import openpyxl
import json
import os

file_path = 'data/4_Original_unmodified_QUIPS_tool/AIME201302190-00009_suppl1.xlsx'
output_path = 'quips_tool.json'

if not os.path.exists(file_path):
    print(f"Error: File not found at {file_path}")
    exit(1)

try:
    wb = openpyxl.load_workbook(file_path)
    ws = wb.active # Assuming the tool is on the active sheet
    
    quips_data = {
        "title": "QUIPS Risk of Bias Assessment Instrument for Prognostic Factor Studies",
        "domains": []
    }

    # Helper to find data validation for a cell
    def get_validation_options(cell, sheet):
        for dv in sheet.data_validations.dataValidation:
            if cell.coordinate in dv:
                # Formula1 usually contains the options like "Yes,No,Partial,Unsure" or a reference
                return dv.formula1
        return None

    # Iterate through rows to find the structure. 
    # This part relies on some assumption of structure or just dumping logical blocks.
    # Based on the background doc, there are 6 domains.
    # I'll iterate and try to group by domains based on headers.

    current_domain = None
    current_items = []
    
    # Simple extraction for now: row by row, capturing text and potential dropdowns
    rows_data = []
    
    for row in ws.iter_rows():
        row_content = []
        for cell in row:
            val = cell.value
            validation = get_validation_options(cell, ws)
            
            cell_data = {
                "text": str(val).strip() if val else None,
                "coordinate": cell.coordinate
            }
            if validation:
                cell_data["dropdown_options"] = validation
            
            # Only add non-empty cells to reduce noise, but keep structure if needed
            if val or validation:
                row_content.append(cell_data)
        
        if row_content:
            rows_data.append(row_content)

    quips_data["raw_rows"] = rows_data
    
    with open(output_path, 'w') as f:
        json.dump(quips_data, f, indent=2)
        
    print(f"Successfully converted '{file_path}' to '{output_path}'")

except Exception as e:
    print(f"An error occurred: {e}")
