#!/bin/bash

# Directories to save the models
SAVE_DIR="/root/stable-diffusion-webui/models/Stable-diffusion"
VAE_DIR="/root/stable_diffusion-webui/models/VAE"
CONTROLNET_DIR="/root/stable_diffusion-webui/models/VAE"
mkdir -p "$SAVE_DIR"
mkdir -p "$VAE_DIR"

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

# Download the VAE model
VAE_URL="https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors"
VAE_FILE_NAME="$(basename "$VAE_URL")"
VAE_DEST_PATH="$VAE_DIR/$VAE_FILE_NAME"

if [ -f "$VAE_DEST_PATH" ]; then
    echo "$VAE_FILE_NAME already exists, skipping download."
else
    echo "Downloading $VAE_FILE_NAME..."
    wget -O "$VAE_DEST_PATH" "$VAE_URL" || { echo "Failed to download $VAE_FILE_NAME"; exit 1; }
    echo "$VAE_FILE_NAME downloaded successfully."
fi
