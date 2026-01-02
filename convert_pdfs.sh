#!/bin/bash

# Define source and destination directories
SOURCE_DIR="data/2_Articles_per_systematic_review"
DEST_DIR="data_md_converted"

# Check if marker_single is installed
if ! command -v marker_single &> /dev/null; then
    echo "Error: 'marker_single' is not installed or not in your PATH."
    echo "Please install it (e.g., 'pip install marker-pdf') before running this script."
    exit 1
fi

echo "Starting PDF conversion from '$SOURCE_DIR' to '$DEST_DIR'..."

# Find all PDF files in the source directory and process them
find "$SOURCE_DIR" -type f -name "*.pdf" | while read -r pdf_file; do
    # Get the relative path of the file (e.g., "1_Giuliano_2021/Arntsen_2017.pdf")
    relative_path="${pdf_file#$SOURCE_DIR/}"
    
    # Get the directory part of the relative path
    subdir=$(dirname "$relative_path")
    
    # Get the filename without extension
    filename=$(basename "$pdf_file" .pdf)
    
    # Construct the full output directory path
    output_dir="$DEST_DIR/$subdir"
    
    # Skip if output already exists
    if [ -f "$output_dir/$filename.md" ]; then
        echo "Skipping: $filename.md already exists in $output_dir"
        continue
    fi

    # Create the output directory if it doesn't exist
    mkdir -p "$output_dir"
    
    echo "Converting: $pdf_file"
    
    # Execute marker_single
    # --disable_image_extraction: Prevents extracting images to separate files
    # Note: We omit --max_pages to process the full document.
    # Note: We omit --langs to allow marker to auto-detect (supports Spanish, Portuguese, Chinese, etc.)
    marker_single "$pdf_file" --output_dir "$output_dir" --disable_image_extraction
    
    # Flatten the output:
    # Marker creates "$output_dir/$filename/" containing "$filename.md" (or similar).
    # We want "$output_dir/$filename.md".
    
    marker_output_folder="$output_dir/$filename"
    
    if [ -d "$marker_output_folder" ]; then
        # Find the markdown file inside the folder (usually filename.md, sometimes README.md or other)
        md_file=$(find "$marker_output_folder" -maxdepth 1 -name "*.md" | head -n 1)
        
        if [ -n "$md_file" ]; then
            # Move it to the parent dir with the correct name
            mv "$md_file" "$output_dir/$filename.md"
            # Remove the marker created folder and any json/meta files inside
            rm -rf "$marker_output_folder"
        else
            echo "Warning: No markdown file found in $marker_output_folder"
        fi
    fi
    
done

echo "Conversion process complete."