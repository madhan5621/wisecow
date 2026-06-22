#!/bin/sh

# Usage: sh automated_backup.sh <source_dir> <backup_dir>

SOURCE=$1
DEST=$2
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"
LOG_FILE="backup_log.txt"

if [ -z "$SOURCE" ] || [ -z "$DEST" ]; then
    echo "Usage: sh automated_backup.sh <source_dir> <backup_dir>"
    exit 1
fi

if [ ! -d "$SOURCE" ]; then
    echo "ERROR: Source directory $SOURCE does not exist"
    exit 1
fi

mkdir -p "$DEST"

echo "---- Backup Started: $TIMESTAMP ----" | tee -a $LOG_FILE

tar -czf "$DEST/$BACKUP_NAME" "$SOURCE" 2>/dev/null

if [ $? -eq 0 ]; then
    SIZE=$(ls -lh "$DEST/$BACKUP_NAME" | awk '{print $5}')
    echo "SUCCESS: Backup created at $DEST/$BACKUP_NAME (Size: $SIZE)" | tee -a $LOG_FILE
else
    echo "FAILED: Backup of $SOURCE failed" | tee -a $LOG_FILE
    exit 1
fi

echo "---- Backup Complete ----" | tee -a $LOG_FILE