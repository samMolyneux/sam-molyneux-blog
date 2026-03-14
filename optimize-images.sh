#!/bin/bash

# Image optimization script
# Usage: ./optimize-images.sh <directory> [max-width] [quality]
# Example: ./optimize-images.sh images/agadir 1920 85

set -e

DIR="${1:-.}"
MAX_WIDTH="${2:-1920}"
QUALITY="${3:-85}"

if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' does not exist"
    exit 1
fi

# Check for ImageMagick
if ! command -v magick &> /dev/null; then
    echo "Error: ImageMagick is not installed"
    echo "Install with: sudo pacman -S imagemagick"
    exit 1
fi

echo "Optimizing images in: $DIR"
echo "Max width: ${MAX_WIDTH}px, Quality: ${QUALITY}%"
echo ""

count=0
saved=0

shopt -s nullglob
for img in "$DIR"/*.jpg "$DIR"/*.jpeg "$DIR"/*.JPG "$DIR"/*.JPEG "$DIR"/*.png "$DIR"/*.PNG; do
    [ -f "$img" ] || continue

    original_size=$(stat -c%s "$img")
    original_kb=$((original_size / 1024))

    # Read EXIF creation date before stripping
    exif_date=$(magick identify -format '%[EXIF:DateTimeOriginal]' "$img" 2>/dev/null || echo "")

    echo -n "Processing: $(basename "$img") (${original_kb}KB) -> "

    magick "$img" -auto-orient -resize "${MAX_WIDTH}x>" -quality "$QUALITY" -strip "$img"

    new_size=$(stat -c%s "$img")
    new_kb=$((new_size / 1024))
    saved_kb=$((original_kb - new_kb))

    # Detect orientation from dimensions
    dims=$(magick identify -format '%w %h' "$img")
    w=$(echo "$dims" | cut -d' ' -f1)
    h=$(echo "$dims" | cut -d' ' -f2)
    if [ "$h" -gt "$w" ]; then
        orientation="portrait"
    else
        orientation="landscape"
    fi

    echo "${new_kb}KB (saved ${saved_kb}KB) [${orientation}] [date:${exif_date}]"

    count=$((count + 1))
    saved=$((saved + saved_kb))
done

if [ $count -eq 0 ]; then
    echo "No images found in $DIR"
else
    echo ""
    echo "Done! Processed $count images, saved ${saved}KB total"
fi
