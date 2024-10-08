#!/bin/bash

# Variables
FILE_ID="1p8COShykwfPvkA7r-_jM5VFN4feMZm_P"  # Replace this with your Google Drive file ID
FILE_NAME="your_file.zip"  # Replace this with the desired output file name

# Step 1: Save cookies and initiate download
echo "Fetching cookies and initiating download..."
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=$FILE_ID" -O /dev/null --save-cookies /tmp/cookies.txt --keep-session-cookies

# Step 2: Extract confirmation token from cookies and download the file
echo "Downloading the file..."
CONFIRM=$(awk '/download/ {print $NF}' /tmp/cookies.txt)
wget --no-check-certificate "https://drive.google.com/uc?export=download&confirm=$CONFIRM&id=$FILE_ID" -O "$FILE_NAME" --load-cookies /tmp/cookies.txt

# Step 3: Unzip the file based on its extension
echo "Extracting the file..."
if [[ $FILE_NAME == *.zip ]]; then
    unzip "$FILE_NAME"
elif [[ $FILE_NAME == *.tar.gz ]]; then
    tar -xzvf "$FILE_NAME"
elif [[ $FILE_NAME == *.tar.xz ]]; then
    tar -xJvf "$FILE_NAME"
elif [[ $FILE_NAME == *.tar.bz2 ]]; then
    tar -xjvf "$FILE_NAME"
else
    echo "Unsupported file format!"
    exit 1
fi

# Step 4: Clean up
echo "Cleaning up..."
rm -f /tmp/cookies.txt
rm -f "$FILE_NAME"

echo "Done!"
