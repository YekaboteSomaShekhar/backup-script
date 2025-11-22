## Automatic Backup System (Bash Script)

### Project Overview
The **Automatic Backup System** is a Bash script designed to create automatic backups of important files or directories. It compresses a specified folder into a timestamped `.tar.gz` archive, generates a checksum for verification, logs every operation, and automatically removes old backups based on rotation rules (daily, weekly, monthly).

### Why is it useful?
 
+ Manual backups are error-prone and time-consuming.
+ This script provides a reliable, repeatable, and space-efficient solution for managing backups — ensuring important data is always protected without human intervention.
+ It’s ideal for personal systems, small businesses, or developers who need regular backups of project directories or configuration files.

### How to Use It?
#### Installation Steps:
1. **Install Windows Subsystem for Linux(WSL) if you’re using Windows:**

```
wsl --install
```

3. **Clone or create the project folder:**

```
mkdir backup system
```
3. **Add the files:**
   
+ `backup.sh` → main script
+ `backup.config` → configuration file
+ `backup.log`→ log file
+ `README.md` → documentation

4. **Make the script executable:**

```
chmod +x backup.sh
./backup.sh
```

**Basic Usage Examples**
- Create a new backup
```
./backup.sh /mnt/c/Users/lenovo/OneDrive/Documents/myfiles
```
- Dry-run mode
```
./backup.sh --dry-run /mnt/c/Users/lenovo/OneDrive/Documents/myfiles
```
- Example Output:
```
[2025-11-22 08:10:12] INFO: Starting backup of /mnt/c/Users/lenovo/OneDrive/Documents/myfiles
[2025-11-22 08:10:15] SUCCESS: Backup created and verified: backup-2025-11-22-0810.tar.gz
```
### How It Works

**Backup Rotation Algorithm**

The script keeps your backup folder clean by deleting older backups automatically:
- **Daily**: Keeps the last 7 daily backups.
- **Weekly**: Keeps the last 4 weekly backups.
- **Monthly**: Keeps the last 3 monthly backups.

### Checksum Verification
Each backup file has a unique MD5 checksum created immediately after the backup:

```
md5sum backup-2025-11-22-1017.tar.gz > backup-2025-11-22-1017.tar.gz.md5
```
### Folder Structure for Backups

```
/mnt/c/Users/lenovo/OneDrive/Documents/backups/
│
├── backup-2025-11-20-1017.tar.gz
├── backup-2025-11-21-1017.tar.gz.md5
└── backup.log
```

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
