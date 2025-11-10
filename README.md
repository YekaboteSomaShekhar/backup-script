## Automatic Backup System (Bash Script)

### Project Overview
The **Automatic Backup System** is a Bash script designed to create automatic backups of important files or directories.  
It copies files from a **source directory** to a **backup directory**, stores them in timestamped folders, and maintains a log file for tracking all backup operations.

### Objectives
- Automate the file backup process using Bash scripting.  
- Organize backups by date and time.  
- Maintain a detailed log file for every backup.  
- Optionally remove old backups to save storage space.

### Features
1. Automatically copies files from the source folder to the backup folder.  
2. Creates a new folder for each backup with a timestamp.  
3. Logs every operation with success/failure status.  
4. Deletes backups older than 7 days (optional cleanup).  
5. Easy to customize and schedule with cron jobs.  

### Technologies Used
- **Bash (Shell Scripting)**
- **Linux/Unix Command Line Tools:** `cp`, `mkdir`, `find`, `date`, `ls`, `wc`

### Script Information
**Script name:** `automatic_backup.sh`

### Variables Used
| Variable | Description |
|-----------|-------------|
| `SOURCE_DIR` | The folder containing files to back up |
| `BACKUP_DIR` | The main backup folder where backups are stored |
| `LOG_FILE` | The file where backup logs are saved |
| `TIMESTAMP` | Stores the current date and time for naming backup folders |
