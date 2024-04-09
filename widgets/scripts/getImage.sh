#!/bin/bash

# Get the album art URL using playerctl
art_url=$(playerctl metadata --format '{{ (mpris:artUrl) }}' --player=spotify)

# Check if the art URL exists
if [ -n "$art_url" ]; then
    # Get the cache directory location
    cache_dir="$HOME/.album_art_cache"
    
    # Create the cache directory if it doesn't exist
    mkdir -p "$cache_dir"

    # Delete all images in the cache
    rm -f "$cache_dir"/*

    # Get the file name from the URL (last part of the URL)
    filename=$(basename "$art_url")

    # Create the full file path in the cache
    cache_path="$cache_dir/$filename"

    # Download the image
    wget -O "$cache_path" "$art_url" > /dev/null 2>&1

    # Display the path to the cached image
    echo "$cache_path"
else
    echo "Failed to get the album art URL."
fi
