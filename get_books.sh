#!/bin/bash
set -euo pipefail

if [ $# -ne 2 ]; then
    echo "Usage: bash get_books.sh BUCKET BOOK_DIR" >&2
    exit 1
fi

bucket="$1"
mkdir -p "$2"
book_dir="$(realpath "$2")"

# Download only the .txt files
aws s3 cp "s3://$bucket/" "$book_dir" --recursive --exclude "*" --include "*.txt"

echo "File path" > book_list.txt
find "$book_dir" -name "*.txt" | sort >> book_list.txt

# Count the books (skip the header)
count=$(tail -n +2 book_list.txt | wc -l)
echo "Wrote $count book files to book_list.txt"
