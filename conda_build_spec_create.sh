#!/bin/bash

# Path to your local packages directory
PACKAGES_DIR="/home/enisbe/conda_packages"

# Original spec file
SPEC_FILE="conda_build_spec.txt"

# Output spec file
LOCAL_SPEC_FILE="conda_build_spec_local.txt"

# Start the new spec file
echo "@EXPLICIT" > "$LOCAL_SPEC_FILE"

# Read the original spec file
while read -r line; do
    if [[ "$line" == "#"* ]] || [[ "$line" == "" ]]; then
        # Skip comments and empty lines
        continue
    elif [[ "$line" == "@EXPLICIT" ]]; then
        # Skip @EXPLICIT line (already added)
        continue
    else
        # Extract the package filename
        FILENAME=$(basename "$line")
        # Construct the local file URL
        LOCAL_URL="file://$PACKAGES_DIR/$FILENAME"
        # Append to the local spec file
        echo "$LOCAL_URL" >> "$LOCAL_SPEC_FILE"
    fi
done < "$SPEC_FILE"
