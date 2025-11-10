#!/bin/bash
# ------------------------------------------------------------
# Automatic Backup System
# Description: Backs up files from source to destination folder
# ------------------------------------------------------------

# Define source and destination directories
SOURCE_DIR="/home/user/Documents/myfiles"
BACKUP_DIR="/home/user/Backups"
LOG_FILE="/home/user/Backups/backup_log.txt"

# Create backup folder with timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
DEST_DIR="$BACKUP_DIR/backup_$TIMESTAMP"

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "[$(date)] ERROR: Source directory not found!" >> "$LOG_FILE"
    exit 1
fi

# Create destination directory if not exists
mkdir -p "$DEST_DIR"

# Perform backup using rsync or cp
cp -r "$SOURCE_DIR"/* "$DEST_DIR"/ 2>> "$LOG_FILE"

# Check success and log the result
if [ $? -eq 0 ]; then
    FILE_COUNT=$(ls -1 "$SOURCE_DIR" | wc -l)
    echo "[$(date)] Backup successful! $FILE_COUNT files copied to $DEST_DIR" >> "$LOG_FILE"
else
    echo "[$(date)] Backup failed!" >> "$LOG_FILE"
    exit 1
fi

# Optional: Delete old backups (older than 7 days)
find "$BACKUP_DIR" -type d -mtime +7 -exec rm -rf {} \; 2>> "$LOG_FILE"

echo "Backup completed successfully!"
