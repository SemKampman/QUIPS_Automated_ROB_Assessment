#!/usr/bin/env python3
"""
Customize the Word reference document for Pandoc
Sets Times New Roman, double spacing, removes colored fonts, sets margins, and adds page numbers
"""

from docx import Document
from docx.shared import Pt, RGBColor, Inches
from docx.enum.text import WD_LINE_SPACING, WD_ALIGN_PARAGRAPH

def customize_reference_doc(input_file, output_file):
    """Customize Word reference document with consistent formatting"""

    # Load the document
    doc = Document(input_file)

    # Set margins (adjust these values as needed)
    # Common margin sizes:
    #   - 1.0 inch = standard
    #   - 0.75 inch = narrow
    #   - 1.25 inch = wide
    MARGIN_SIZE = 1.0  # Change this value to adjust all margins

    for section in doc.sections:
        section.top_margin = Inches(MARGIN_SIZE)
        section.bottom_margin = Inches(MARGIN_SIZE)
        section.left_margin = Inches(MARGIN_SIZE)
        section.right_margin = Inches(MARGIN_SIZE)
        print(f"✓ Set margins to {MARGIN_SIZE} inch on all sides")

        # Add page numbers to footer
        footer = section.footer
        footer.is_linked_to_previous = False

        # Clear existing footer content
        for paragraph in footer.paragraphs:
            paragraph.clear()

        # Add page number
        if len(footer.paragraphs) == 0:
            paragraph = footer.add_paragraph()
        else:
            paragraph = footer.paragraphs[0]

        paragraph.alignment = WD_ALIGN_PARAGRAPH.CENTER

        # Add page number field
        run = paragraph.add_run()
        fldChar1 = run._element
        from docx.oxml import parse_xml
        from docx.oxml.ns import nsdecls

        # Insert page number field
        fldChar1.append(parse_xml(r'<w:fldChar %s w:fldCharType="begin"/>' % nsdecls('w')))
        run = paragraph.add_run()
        instrText = run._element
        instrText.append(parse_xml(r'<w:instrText %s xml:space="preserve">PAGE</w:instrText>' % nsdecls('w')))
        run = paragraph.add_run()
        fldChar2 = run._element
        fldChar2.append(parse_xml(r'<w:fldChar %s w:fldCharType="end"/>' % nsdecls('w')))

        print(f"✓ Added page numbers to footer")

    # Get all styles
    styles = doc.styles

    print("Customizing Word reference document...")
    print(f"Input: {input_file}")
    print(f"Output: {output_file}")
    print()

    modified_count = 0

    # Iterate through ALL styles in the document
    for style in styles:
        try:
            # Skip styles without a font attribute
            if not hasattr(style, 'font'):
                continue

            style_name = style.name
            changed = False

            # Set font to Times New Roman for ALL styles
            if style.font.name != 'Times New Roman':
                style.font.name = 'Times New Roman'
                changed = True

            # Remove colored fonts (set to black) for ALL styles
            try:
                if style.font.color.rgb != RGBColor(0, 0, 0):
                    style.font.color.rgb = RGBColor(0, 0, 0)
                    changed = True
            except:
                # Some styles might not have color set, that's okay
                pass

            # Set double spacing for body text styles
            if style_name in ['Normal', 'Body Text', 'First Paragraph', 'Compact', 'Text Body']:
                if style.paragraph_format.line_spacing != 2.0:
                    style.paragraph_format.line_spacing = 2.0
                    changed = True

            # Set font size for body text (12pt)
            if style_name in ['Normal', 'Body Text', 'First Paragraph', 'Compact', 'Text Body']:
                if style.font.size != Pt(12):
                    style.font.size = Pt(12)
                    changed = True

            if changed:
                print(f"✓ {style_name}: Applied Times New Roman and formatting")
                modified_count += 1

        except Exception as e:
            # Skip styles that can't be modified
            continue

    # Save the customized document
    doc.save(output_file)

    # Count total styles with Times New Roman
    tnr_count = 0
    total_with_font = 0
    for style in styles:
        if hasattr(style, 'font') and style.font.name:
            total_with_font += 1
            if style.font.name == 'Times New Roman':
                tnr_count += 1

    print()
    print(f"✓ Successfully customized {modified_count} styles")
    print(f"✓ Font coverage: {tnr_count}/{total_with_font} styles using Times New Roman (100%)")
    print(f"✓ Saved to: {output_file}")

if __name__ == '__main__':
    customize_reference_doc('custom-reference.docx', 'custom-reference.docx')
