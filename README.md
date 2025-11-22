## Automatic Backup System (Bash Script)

### Project Overview
The **Automatic Backup System** is a Bash script designed to create automatic backups of important files or directories. It compresses a specified folder into a timestamped `.tar.gz` archive, generates a checksum for verification, logs every operation, and automatically removes old backups based on rotation rules (daily, weekly, monthly).

### Why is it useful?
 
+ Manual backups are error-prone and time-consuming.
+ This script provides a reliable, repeatable, and space-efficient solution for managing backups — ensuring important data is always protected without human intervention.
+ It’s ideal for personal systems, small businesses, or developers who need regular backups of project directories or configuration files.

### How to Use It?
#### Installation Steps
**Clone or create the project folder:**

```
mkdir backup system

```
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
