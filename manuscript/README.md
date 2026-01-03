# Manuscript Directory

This directory contains the manuscript source files and build system for the QUIPS automated assessment study.

## 📁 File Structure

```
manuscript/
├── manuscript.md          # Main manuscript content (Markdown)
├── metadata.yaml          # Document metadata (title, authors, affiliations)
├── references.bib         # Bibliography in BibTeX format
├── 00__convert_tables.R   # R script to convert TSV to Markdown tables
├── 01__build.sh           # Build script to generate DOCX/PDF
├── customize_reference.py # Python script to customize Word formatting
├── preprocess.py          # Python script to handle file includes
├── custom-reference.docx  # Custom Word template (auto-generated)
├── README.md              # This documentation
├── .gitignore             # Git ignore rules
├── figures/               # Place figures here (PNG, PDF, SVG)
├── tables/                # Auto-generated Markdown tables
└── output/                # Generated DOCX/PDF files
```

## Quick Start

### 1. Install Requirements

**Required:**
- [Pandoc](https://pandoc.org/installing.html) (>= 2.19)
  ```bash
  # macOS
  brew install pandoc

  # Ubuntu/Debian
  sudo apt-get install pandoc
  ```

- [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref) - for cross-references
  ```bash
  # macOS
  brew install pandoc-crossref

  # Ubuntu/Debian
  # Download from: https://github.com/lierdakil/pandoc-crossref/releases
  ```

**Optional:**
- R (>= 4.0) - for table conversion
- LaTeX - for PDF generation
  ```bash
  # macOS
  brew install --cask mactex

  # Ubuntu/Debian
  sudo apt-get install texlive-full
  ```

- python-docx - for automatic Word formatting customization
  ```bash
  pip install python-docx
  ```

### 2. Build the Manuscript

```bash
cd manuscript
chmod +x 01__build.sh
./01__build.sh
```

This will:
1. Download the Vancouver citation style (if needed)
2. Create custom Word template (if needed)
3. Preprocess manuscript to include external files
4. Generate `output/manuscript.docx` (no TOC, numbered sections)
5. Generate `output/manuscript.pdf` (if LaTeX is installed)

**Note:** Table conversion is now a manual step. To convert TSV tables to Markdown:
```bash
Rscript 00__convert_tables.R
```

### 3. Edit the Manuscript

Open and edit these files:

1. **metadata.yaml** - Add your title, authors, affiliations
2. **manuscript.md** - Fill in the sections marked with "here..."
3. **references.bib** - Add your references

## Writing Guide

### Citations

Use `@citationkey` for citations:

```markdown
Studies have shown... [@Hayden2013]
According to @Hayden2013, the QUIPS tool...
Multiple studies [@Hayden2013; @OtherStudy2021] confirm...
```

### Cross-references

```markdown
See Table @tbl:domain1
As shown in Figure @fig:overview
```

### Tables

**Including external table files:**
Use the include syntax to automatically insert table files during build:
```markdown
{{< include tables/domain1_summary.md >}}
```

The build script will automatically include these files when generating the output.

**Manual Markdown tables:**
```markdown
| Header 1 | Header 2 |
|----------|----------|
| Cell 1   | Cell 2   |
```

### Figures

```markdown
![Caption text](figures/filename.png){#fig:label width=80%}
```

### Equations

Inline: `$E = mc^2$`

Display:
```markdown
$$
\frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
$$
```

## Citation Styles

The default is **Vancouver** (numeric citations). To use a different style:

1. Browse styles at https://www.zotero.org/styles
2. Download the `.csl` file
3. Update `metadata.yaml`:
   ```yaml
   csl: your-style.csl
   ```

Popular styles:
- `vancouver.csl` - Numbered citations [1,2,3]
- `apa.csl` - APA style (Author, Year)
- `nature.csl` - Nature journal style
- `ieee.csl` - IEEE style

## Custom Word Template

The build script automatically creates a custom Word reference document with:
- **Times New Roman** font
- **Double spacing** for body text
- **Black text** (no colored fonts)
- **12pt font** size
- **1 inch margins** on all sides
- **Page numbers** centered in footer

To modify the formatting:

**Option 1: Automatic (Recommended)**
```bash
pip install python-docx
python3 customize_reference.py
```

**Option 2: Manual**
1. Open `custom-reference.docx` in Word
2. Modify the styles (Format → Styles)
3. Save the file

The `01__build.sh` script will automatically use `custom-reference.docx` if it exists.

## Troubleshooting

### "pandoc: command not found"
Install Pandoc: https://pandoc.org/installing.html

### Tables not appearing
1. Ensure you've run the table conversion script: `Rscript 00__convert_tables.R`
2. Check that R is installed
3. Verify that TSV files exist in `../outputs/`
4. Confirm the converted Markdown tables exist in `tables/`

### PDF generation fails
LaTeX is required for PDF. Install:
- macOS: `brew install --cask mactex`
- Linux: `sudo apt-get install texlive-full`

### References not appearing
Check that:
1. `references.bib` is valid BibTeX format
2. Citations in text match keys in `.bib` file
3. `vancouver.csl` exists (auto-downloaded by build script)

## Advanced Options

### Custom Pandoc options

Edit `build.sh` and modify the pandoc command. Useful options:

```bash
--filter pandoc-crossref     # Advanced cross-referencing
--number-sections            # Number all sections
--toc                        # Table of contents
--toc-depth=3               # TOC depth
--standalone                # Complete document
--self-contained            # Embed images in HTML
```

### Multiple output formats

The build script creates DOCX by default. To add other formats:

```bash
# HTML
pandoc manuscript.md --metadata-file=metadata.yaml \
  --bibliography=references.bib --csl=vancouver.csl \
  -o output/manuscript.html --self-contained

# LaTeX
pandoc manuscript.md --metadata-file=metadata.yaml \
  --bibliography=references.bib --csl=vancouver.csl \
  -o output/manuscript.tex
```

## Tips

1. **Version control**: Commit often, especially before major edits
2. **Backup**: Keep your `.bib` file synchronized with a reference manager
3. **Preview**: Build frequently to catch formatting issues early
4. **Figures**: Use vector formats (PDF, SVG) when possible for better quality
5. **Tables**: Keep complex tables in R and auto-generate them

## References

- [Pandoc Manual](https://pandoc.org/MANUAL.html)
- [Pandoc Markdown](https://pandoc.org/MANUAL.html#pandocs-markdown)
- [Citation Style Language](https://citationstyles.org/)
- [BibTeX Format](http://www.bibtex.org/Format/)
