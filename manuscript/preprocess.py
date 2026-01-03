#!/usr/bin/env python3
"""
Preprocess markdown file to include external files
Supports syntax: {{< include path/to/file.md >}}
"""

import sys
import re
from pathlib import Path

def process_includes(input_file, output_file):
    """Process include directives in markdown file"""

    input_path = Path(input_file)
    base_dir = input_path.parent

    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()

    # Pattern to match: {{< include path/to/file.md >}}
    include_pattern = r'\{\{<\s*include\s+([^\s>]+)\s*>\}\}'

    def replace_include(match):
        include_file = match.group(1)
        include_path = base_dir / include_file

        if not include_path.exists():
            print(f"Warning: Include file not found: {include_path}", file=sys.stderr)
            return f"<!-- File not found: {include_file} -->"

        try:
            with open(include_path, 'r', encoding='utf-8') as f:
                included_content = f.read()
            print(f"  ✓ Included: {include_file}")
            return included_content
        except Exception as e:
            print(f"Warning: Could not read {include_file}: {e}", file=sys.stderr)
            return f"<!-- Error reading: {include_file} -->"

    # Replace all include directives
    processed_content = re.sub(include_pattern, replace_include, content)

    # Write output
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(processed_content)

    print(f"✓ Preprocessed: {input_file} -> {output_file}")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: preprocess.py input.md output.md")
        sys.exit(1)

    process_includes(sys.argv[1], sys.argv[2])
