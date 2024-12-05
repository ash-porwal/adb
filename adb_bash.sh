#!/bin/bash

# Set the Android paths
# Below is my Camera from SD storage card
ANDROID_PHOTOS_DIR1="/storage/452E-15F8/DCIM/Camera/"
# Below is my DCIM from internal storage, which covers Camera pics, Snapchats, Screenshot, Screenrecoding
ANDROID_PHOTOS_DIR2="/storage/self/primary/DCIM/"
# Below is my Remove.bg From internal Storage
ANDROID_PHOTOS_DIR3="/storage/self/primary/Pictures/Remove.bg"


# Set the local backup path
LOCAL_BACKUP_DIR="/home/ashish/hdd/ashish_backup/Photos/DCIM/Camera"

# Create the local backup directory if it doesn't exist
mkdir -p "$LOCAL_BACKUP_DIR"

# Function to back up files from an Android directory to the local backup directory
backup_photos() {
    local ANDROID_DIR=$1
    local FILES=$(adb shell ls "$ANDROID_DIR")

    for FILE in $FILES; do
        if [ ! -f "$LOCAL_BACKUP_DIR/$FILE" ]; then
            adb pull "$ANDROID_DIR/$FILE" "$LOCAL_BACKUP_DIR/"
            echo "Copied: $FILE"
        else
            echo "Skipped: $FILE (already exists)"
        fi
    done
}

# Backup from the first Android directory
backup_photos "$ANDROID_PHOTOS_DIR1"

# Backup from the second Android directory
backup_photos "$ANDROID_PHOTOS_DIR2"

backup_photos "$ANDROID_PHOTOS_DIR3"

echo "Backup process completed."

