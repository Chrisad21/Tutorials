#!/bin/bash

# Directories to save the models
SAVE_DIR="/root/stable-diffusion-webui/models/Stable-diffusion"
VAE_DIR="/root/stable_diffusion/models/VAE"
CONTROLNET_DIR="/root/stable_diffusion-webui/models/ControlNet"
mkdir -p "$SAVE_DIR"
mkdir -p "$VAE_DIR"
mkdir -p "$CONTROLNET_DIR"

# List of checkpoint model URLs
CHECKPOINT_MODELS=(
    #CyberRealistic v.8
    "https://civitai.com/api/download/models/1464918?type=Model&format=SafeTensor&size=pruned&fp=fp16&token=3f962f12abed6d1616c5b127e0209c22"
    #CyberRealistic v.8 - inpainting
    "https://civitai.com/api/download/models/1460987?type=Model&format=SafeTensor&size=pruned&fp=fp16&token=3f962f12abed6d1616c5b127e0209c22"
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

# List of ControlNet model URLs
CONTROLNET_MODELS=(
    "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_full.safetensors"
    "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_depth_full.safetensors"
    "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/ioclab_sd15_recolor.safetensors"
    "https://huggingface.co/xinsir/controlnet-openpose-sdxl-1.0/resolve/main/diffusion_pytorch_model.safetensors"
)

# Download each ControlNet model
for URL in "${CONTROLNET_MODELS[@]}"; do
    FILE_NAME="$(basename "$URL")"
    DEST_PATH="$CONTROLNET_DIR/$FILE_NAME"
    
    if [ -f "$DEST_PATH" ]; then
        echo "$FILE_NAME already exists, skipping download."
    else
        echo "Downloading $FILE_NAME..."
        wget -O "$DEST_PATH" "$URL" || { echo "Failed to download $FILE_NAME"; exit 1; }
    fi
    
    echo "$FILE_NAME downloaded successfully."
done
