#!/bin/bash

# Load configuration
CONFIG_FILE="backup.config"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Warning: Config file not found, using defaults."
    BACKUP_DESTINATION="C:\Users\lenovo\OneDrive\Documents\backups"
    EXCLUDE_PATTERNS=".git,node_modules,.cache"
    DAILY_KEEP=7
    WEEKLY_KEEP=4
    MONTHLY_KEEP=3
fi

# Lock file to prevent multiple runs
LOCK_FILE="/tmp/backup.lock"
if [ -e "$LOCK_FILE" ]; then
    echo "Backup already running. Exiting."
    exit 1
fi
touch "$LOCK_FILE"

# Logging function
log() {
    mkdir -p "$BACKUP_DESTINATION"
    LOG_FILE="$BACKUP_DESTINATION/backup.log"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Check arguments
DRY_RUN=0
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=1
    shift
fi

SOURCE_DIR="$1"
if [ -z "$SOURCE_DIR" ] || [ ! -d "$SOURCE_DIR" ]; then
    log "ERROR: Source folder not found: $SOURCE_DIR"
    rm -f "$LOCK_FILE"
    exit 1
fi

# Generate timestamp
TIMESTAMP=$(date +%Y-%m-%d-%H%M)
BACKUP_FILE="$BACKUP_DESTINATION/backup-$TIMESTAMP.tar.gz"
CHECKSUM_FILE="$BACKUP_FILE.md5"

# Exclude patterns for tar
TAR_EXCLUDES=()
IFS=',' read -ra EXCLUDE_ARRAY <<< "$EXCLUDE_PATTERNS"
for item in "${EXCLUDE_ARRAY[@]}"; do
    TAR_EXCLUDES+=(--exclude="$item")
done

create_backup() {
    if [ $DRY_RUN -eq 1 ]; then
        log "Dry run: Would create backup $BACKUP_FILE"
        return
    fi

    log "INFO: Starting backup of $SOURCE_DIR"
    tar -czf "$BACKUP_FILE" "${TAR_EXCLUDES[@]}" -C "$SOURCE_DIR" .
    if [ $? -ne 0 ]; then
        log "FAILED: Backup failed"
        rm -f "$LOCK_FILE"
        exit 1
    fi

    # Create checksum
    md5sum "$BACKUP_FILE" > "$CHECKSUM_FILE"

    # Verify checksum
    md5sum -c "$CHECKSUM_FILE"
    if [ $? -eq 0 ]; then
        log "SUCCESS: Backup created and verified: $BACKUP_FILE"
    else
        log "FAILED: Checksum verification failed"
    fi
}

delete_old_backups() {
    if [ $DRY_RUN -eq 1 ]; then
        log "Dry run: Would delete old backups based on rotation rules"
        return
    fi

    # Simple example: keep last DAILY_KEEP backups (sort by name)
    BACKUPS=($(ls -1t $BACKUP_DESTINATION/backup-*.tar.gz))
    COUNT=${#BACKUPS[@]}
    if [ $COUNT -gt $DAILY_KEEP ]; then
        for ((i=DAILY_KEEP; i<$COUNT; i++)); do
            log "INFO: Deleting old backup: ${BACKUPS[$i]}"
            rm -f "${BACKUPS[$i]}" "${BACKUPS[$i]}.md5"
        done
    fi
}

# Run main functions
create_backup
delete_old_backups

# Clean up lock file
rm -f "$LOCK_FILE"