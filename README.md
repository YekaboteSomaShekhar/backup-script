## Automatic Backup System (Bash Script)

### Project Overview
The **Automatic Backup System** is a Bash script designed to create automatic backups of important files or directories. It compresses a specified folder into a timestamped `.tar.gz` archive, generates a checksum for verification, logs every operation, and automatically removes old backups based on rotation rules (daily, weekly, monthly).

#### Why is it useful?
+ Manual backups are error-prone and time-consuming.
+ This script provides a reliable, repeatable, and space-efficient solution for managing backups — ensuring important data is always protected without human intervention.
+ It’s ideal for personal systems, small businesses, or developers who need regular backups of project directories or configuration files.

### How to Use It?
**Installation Steps:**
1. **Install Windows Subsystem for Linux(WSL) if you’re using Windows:**
- Go to cmd or windows powershell and type:

```
wsl --install
```

2. **Clone or create the project folder:**

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

**Command Options Explained**

| Command                                   | Description                                         |
| ----------------------------------------- | --------------------------------------------------- |
| `./backup.sh <folder>`                    | Creates a backup of the specified folder            |
| `./backup.sh --dry-run <folder>`          | Simulates backup without creating/deleting anything |
| (future) `--restore <file> --to <folder>` | Restores a backup (if implemented)                  |
| (future) `--list`                         | Lists all backups with sizes and timestamps         |

### How It Works?
**Backup Rotation Algorithm**

The script keeps your backup folder clean by deleting older backups automatically:
- **Daily**: Keeps the last 7 daily backups.
- **Weekly**: Keeps the last 4 weekly backups.
- **Monthly**: Keeps the last 3 monthly backups.

**Checksum Verification**
Each backup file has a unique MD5 checksum created immediately after the backup:

```
md5sum backup-2025-11-22-1017.tar.gz > backup-2025-11-22-1017.tar.gz.md5
```
**Folder Structure for Backups**

```
/mnt/c/Users/lenovo/OneDrive/Documents/backups/
│
├── backup-2025-11-20-1017.tar.gz
├── backup-2025-11-21-1017.tar.gz.md5
└── backup.log
```

### Design Decisions
#### Why this approach?

- **Modular functions:** Code is broken into logical functions like create_backup, verify_backup, and delete_old_backups.
- **Configuration-based:** Users can customize behavior using backup.config instead of editing the script.
- **Cross-platform:** Works on Linux and WSL (Windows Subsystem for Linux).
- **Lock file mechanism:** Prevents accidental multiple runs that could corrupt backups.

### Challenges Faced

**1. Windows path compatibility**
- Fixed by using `/mnt/c/Users...` format instead of `C:\...`

**2. Automating deletion logic**
- Implemented a basic rotation system that keeps only the latest backups.

### How They Were Solved?

- Used Linux-standard utilities like `tar`, `md5sum`, and `find`.
- Added logging and error handling for all critical operations.
- Tested each step independently before combining functions.

### Testing
#### How the Script Was Tested?

**Created a sample folder:** `myfiles`

```
mkdir myfiles
echo "This is my first file" > myfiles/test1.txt
echo "This is my backup automation task" > myfiles/test2.txt
```

**Run a backup file:**

```
./backup.sh /mnt/c/Users/lenovo/OneDrive/Documents/myfiles
```

**Dry-run test:**

```
./backup.sh --dry-run /mnt/c/Users/lenovo/OneDrive/Documents/myfiles
```

**Error Handling:**
```
./backup.sh /mnt/c/Users/lenovo/OneDrive/Documents/myflies
```
**Output**
```
[ERROR]: Source folder not found: /mnt/c/Users/lenovo/OneDrive/Documents/myflies
```

**Output (from backup.log):**

```
[2025-11-22 10:09:22] INFO: Starting backup of /mnt/c/Users/lenovo/OneDrive/Documents/myfiles
[2025-11-22 10:09:22] SUCCESS: Backup created and verified: /mnt/c/Users/lenovo/OneDrive/Documents/backups/backup-2025-11-22-1009.tar.gz
```
**Restoring a Backup:**

```
./backup.sh --restore backup-2025-11-22-0810.tar.gz --to /mnt/c/Users/lenovo/OneDrive/Documents/restored_files
```

### Limitations

- Rotation	Currently supports daily cleanup; weekly/monthly cleanup to be added.
- Restore	was not yet implemented.
- Incremental backups	Only full backups are supported.
- Email notifications	Not active (simulation possible via log or text output).

### Conclusion

This Automated Backup System provides a practical and extensible way to secure files automatically using Bash. It ensures:
- Data safety via verified backups
- Space optimization via rotation
- Ease of use with configuration and logging
- It’s a great foundation for learning real-world shell scripting and automation practices.
