#!/bin/bash

# Shell script to copy feed content from docker container and commit changes
# Source: /home/ubuntu/docker/wechat2rss/data/web/feed
# Destination: current directory/feed/

# Check if source directory exists
SOURCE_DIR="/home/ubuntu/docker/wechat2rss/data/web/feed"
DEST_DIR="./feed"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist!"
    exit 1
fi

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy contents from source to destination
echo "Copying contents from $SOURCE_DIR to $DEST_DIR..."
cp -r "$SOURCE_DIR"/* "$DEST_DIR/"

# Check if copy was successful
if [ $? -eq 0 ]; then
    echo "Copy completed successfully!"
else
    echo "Error: Copy failed!"
    exit 1
fi

# Git operations
echo "Adding files to git..."
git pull
git config user.name "D.Yang"
git config user.email "koyangslash@gmail.com"
git add feed/

# Commit changes
echo "Creating commit..."
git commit -m "Update feed content - $(date '+%Y-%m-%d %H:%M:%S')"
git push

echo "Script completed successfully!"
