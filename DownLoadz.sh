#!/bin/bash

# Directory to save the models
SAVE_DIR="/root/stable-diffusion-webui/models/Stable-diffusion"
mkdir -p "$SAVE_DIR"

# List of checkpoint model URLs
CHECKPOINT_MODELS=(
    "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
    "https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"
)

# Download each model
for URL in "${CHECKPOINT_MODELS[@]}"; do
    FILE_NAME="$(basename "$URL")"
    DEST_PATH="$SAVE_DIR/$FILE_NAME"
    
    if [ -f "$DEST_PATH" ]; then
        echo "$FILE_NAME already exists, skipping download."
    else
        echo "Downloading $FILE_NAME..."
        wget -O "$DEST_PATH" "$URL" || { echo "Failed to download $FILE_NAME"; exit 1; }
    fi
    
    echo "$FILE_NAME downloaded successfully."
done
