#!/bin/bash
#
# Manuscript build script
# Converts Markdown to DOCX using Pandoc
#
# Usage: ./build.sh
#
# Requirements:
# - pandoc (>= 2.19)
# - R (for table conversion)
# - rmarkdown package in R

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "Building manuscript..."
echo "=========================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo -e "${RED}Error: pandoc is not installed${NC}"
    echo "Install with: brew install pandoc (macOS) or apt-get install pandoc (Linux)"
    exit 1
fi

# Download citation style if not present
if [ ! -f "vancouver.csl" ]; then
    echo -e "${BLUE}Step 1: Downloading Vancouver citation style...${NC}"
    curl -o vancouver.csl "https://raw.githubusercontent.com/citation-style-language/styles/master/vancouver.csl"
    echo -e "${GREEN}✓ Citation style downloaded${NC}"
else
    echo -e "${GREEN}✓ Citation style already present${NC}"
fi

# Create directories if they don't exist
mkdir -p figures
mkdir -p tables
mkdir -p output

# Create custom reference document if it doesn't exist
if [ ! -f "custom-reference.docx" ]; then
    echo -e "${BLUE}Creating custom Word reference document...${NC}"
    pandoc --print-default-data-file reference.docx > custom-reference.docx

    # Customize the reference document with python if available
    if command -v python3 &> /dev/null; then
        if python3 -c "import docx" 2>/dev/null; then
            python3 customize_reference.py
            echo -e "${GREEN}✓ Custom reference created (Times New Roman, double spacing)${NC}"
        else
            echo -e "${BLUE}Note: Install python-docx to auto-customize formatting${NC}"
            echo -e "${BLUE}      Run: pip install python-docx && python3 customize_reference.py${NC}"
        fi
    fi
fi

# Preprocess markdown to include external files
echo -e "${BLUE}Step 2: Preprocessing markdown (includes)...${NC}"
if command -v python3 &> /dev/null; then
    python3 preprocess.py manuscript.md manuscript_processed.md
    MANUSCRIPT_FILE="manuscript_processed.md"
else
    echo -e "${BLUE}Note: Python3 not found, skipping preprocessing${NC}"
    MANUSCRIPT_FILE="manuscript.md"
fi

# Build DOCX
echo -e "${BLUE}Step 3: Building DOCX...${NC}"

# Build pandoc command with optional reference doc
PANDOC_CMD="pandoc $MANUSCRIPT_FILE \
    --metadata-file=metadata.yaml \
    --bibliography=references.bib \
    --csl=vancouver.csl"

# Add reference doc if it exists
if [ -f "custom-reference.docx" ]; then
    PANDOC_CMD="$PANDOC_CMD --reference-doc=custom-reference.docx"
else
    echo -e "${BLUE}Note: Using default Pandoc styling (custom-reference.docx not found)${NC}"
fi

PANDOC_CMD="$PANDOC_CMD \
    --filter pandoc-crossref \
    --citeproc \
    --number-sections \
    -f markdown+table_captions \
    -o output/manuscript.docx"

eval $PANDOC_CMD

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ DOCX created: output/manuscript.docx${NC}"
else
    echo -e "${RED}✗ Error creating DOCX${NC}"
    exit 1
fi

# Build PDF (optional - requires LaTeX)
echo -e "${BLUE}Step 4: Building PDF (optional)...${NC}"
if command -v pdflatex &> /dev/null; then
    pandoc $MANUSCRIPT_FILE \
        --metadata-file=metadata.yaml \
        --bibliography=references.bib \
        --csl=vancouver.csl \
        --filter pandoc-crossref \
        --citeproc \
        --number-sections \
        --pdf-engine=pdflatex \
        -o output/manuscript.pdf

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ PDF created: output/manuscript.pdf${NC}"
    else
        echo -e "${RED}✗ Error creating PDF (LaTeX may not be properly configured)${NC}"
    fi
else
    echo -e "${RED}Note: pdflatex not found. Skipping PDF generation.${NC}"
    echo "Install LaTeX to enable PDF output:"
    echo "  macOS: brew install --cask mactex"
    echo "  Linux: sudo apt-get install texlive-full"
fi

# Clean up temporary files
if [ -f "manuscript_processed.md" ]; then
    rm manuscript_processed.md
fi

echo ""
echo "=========================================="
echo -e "${GREEN}Build complete!${NC}"
echo "=========================================="
echo "Output files:"
echo "  - output/manuscript.docx"
if [ -f "output/manuscript.pdf" ]; then
    echo "  - output/manuscript.pdf"
fi
echo ""
echo "Next steps:"
echo "  1. Open output/manuscript.docx in Word"
echo "  2. Review formatting and tables"
echo "  3. Add any final manual adjustments"
