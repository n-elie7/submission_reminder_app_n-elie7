# How to Run the Submission Reminder Application

## Prerequisites

Before you begin, make sure you have:
- A Unix-based system (Linux or macOS)
- Bash shell installed
- Git installed on your system
- Terminal/Command line access

---

## Installation Steps

### Step 1: Clone the Repository

First, clone the project repository from GitHub:

```bash
git clone https://github.com/n-elie7/submission_reminder_app_n-elie7.git
```

### Step 2: Navigate to the Project Directory

```bash
cd submission_reminder_app_n-elie7
```

### Step 3: Run the Setup Script

1. Make the setup script executable:
   ```bash
   chmod +x create_environment.sh
   ```

2. Run the script:
   ```bash
   ./create_environment.sh
   ```

3. When prompted, enter your name:
   ```
   Please enter your name: John
   ```

**Expected Output:**
```
Please enter your name: John
Creating config.env...
config.env file created successfully
Creating functions.sh...
functions.sh file created successfully
Creating reminder.sh...
reminder.sh file created successfully
Creating submissions.txt...
submissions.txt file created successfully
Creating startup.sh
startup.sh file created successfully
```

### Step 4: Navigate to Your Application Directory

After the setup completes, navigate to the newly created directory:

```bash
cd submission_reminder_John  # Replace 'John' with the name you entered
```

---

## Running the Application

### Basic Usage

To run the application and see which students haven't submitted:

```bash
./startup.sh
```

**Expected Output:**
```
Starting submission reminder app
Loading reminder application...
Assignment: Shell Navigation
Days remaining to submit: 2 days
--------------------------------------------
Checking submissions in ./assets/submissions.txt
Reminder: Chinemerem has not submitted the Shell Navigation assignment!
Reminder: Divine has not submitted the Shell Navigation assignment!
Application completed successfully.
```

---

## Changing the Assignment

To check reminders for a different assignment:

### Step 1: Run the Copilot Script

```bash
./copilot_shell_script.sh
```

### Step 2: Enter New Assignment Name

When prompted, type the name of the assignment you want to check:
```
Enter the new assignment name: DevOps Tools
```

**Expected Output:**
```
Enter the new assignment name: DevOps Tools
Updating assignment in configuration file...
Configuration updated successfully!
New Assignment: DevOps Tools
Restarting Application / rerun startup.sh
Starting submission reminder app
Loading reminder application...
Assignment: DevOps Tools
Days remaining to submit: 2 days
--------------------------------------------
Checking submissions in ./assets/submissions.txt
Reminder: Oliver has not submitted the DevOps Tools assignment!
Application completed successfully.
  Configuration Update Complete
```

The application will automatically:
1. Update the configuration file
2. Restart the application
3. Display students who haven't submitted the new assignment

---

## Available Assignments

Based on the sample data, you can check these assignments:
- Shell Navigation
- Git
- Shell Basics
- Docker Basics
- Linux Commands
- Python Scripting
- Database Design
- Web Development
- API Integration
- Cloud Computing
- Cybersecurity
- DevOps Tools
- Kubernetes

**Note:** Assignment names are case-sensitive and must match exactly as they appear in `assets/submissions.txt`

---

## Adding New Students

To add more students to track:

1. Open the submissions file:
   ```bash
   nano assets/submissions.txt
   ```

2. Add new entries following this format:
   ```
   student, assignment, submission status
   ```

   Example:
   ```
   Michael Johnson, Git, not submitted
   Sarah Williams, Docker Basics, submitted
   ```

3. Save and exit (Ctrl+X, then Y, then Enter)

4. Run the application to see updated results:
   ```bash
   ./startup.sh
   ```

---

## Troubleshooting

### Issue: "Permission denied"

**Solution:**
```bash
chmod +x startup.sh
chmod +x copilot_shell_script.sh
```

### Issue: "Config file not found"

**Solution:**
Make sure you're in the correct directory:
```bash
pwd
# Should show: .../submission_reminder_{yourName}

# If not, navigate there:
cd submission_reminder_{yourName}
```

### Issue: "No students found" / No reminders displayed

**Possible causes:**

1. **All students have submitted** (good news!) 
2. **Assignment name doesn't match exactly:**
   - Check your config:
     ```bash
     cat config/config.env
     ```
   - Verify assignment names in data:
     ```bash
     cat assets/submissions.txt
     ```
   - Make sure spelling and capitalization match exactly

3. **Wrong submission status:**
   - The app only shows "not submitted" status
   - "pending" status is not considered in this version

### Issue: Git clone fails

**Solution:**
```bash
# Make sure git is installed
git --version

# If not installed, install git first:
# On Ubuntu/Debian:
sudo apt-get install git

# On macOS:
brew install git
```

---

## Quick Command Reference

| Task | Command |
|------|---------|
| Clone repository | `git clone https://github.com/n-elie7/submission_reminder_app_n-elie7.git` |
| Run setup script | `./create_environment.sh` |
| Run application | `./startup.sh` |
| Change assignment | `./copilot_shell_script.sh` |
| View current config | `cat config/config.env` |
| View student data | `cat assets/submissions.txt` |
| Edit config manually | `nano config/config.env` |
| Add students | `nano assets/submissions.txt` |

---

## Complete Workflow Example

Here's a typical session from start to finish:

```bash
# 1. Clone the repository
git clone https://github.com/n-elie7/submission_reminder_app_n-elie7.git

# 2. Navigate to project
cd submission_reminder_app_n-elie7

# 3. Run setup
./create_environment.sh
# Enter your name: John

# 4. Navigate to your app directory
cd submission_reminder_John

# 5. Run the application
./startup.sh
# See reminders for Shell Navigation

# 6. Check another assignment
./copilot_shell_script.sh
# Enter: Git
# See reminders for Git assignment

# 7. Check another assignment
./copilot_shell_script.sh
# Enter: DevOps Tools
# See reminders for DevOps Tools assignment
```

---

## Success Indicators

You'll know everything is working correctly when:

**After Setup:**
- All files created successfully messages appear
- New directory `submission_reminder_{yourName}` is created
- All subdirectories (app, modules, assets, config) exist

**After Running Application:**
- "Starting submission reminder app" message appears
- Assignment name and days remaining are displayed
- Student names appear with "Reminder:" prefix (if they haven't submitted)
- "Application completed successfully" message shows
- No error messages appear

**After Using Copilot Script:**
- "Configuration updated successfully!" message appears
- New assignment name is confirmed
- Application automatically restarts
- New reminders are displayed

---

## Directory Structure

After installation, your structure will look like this:

```
submission_reminder_{yourName}/
├── app/
│   └── reminder.sh              # Main application logic
├── modules/
│   └── functions.sh             # Helper functions
├── assets/
│   └── submissions.txt          # Student data (CSV format)
├── config/
│   └── config.env               # Configuration settings
├── startup.sh                   # Application launcher
└── copilot_shell_script.sh      # Assignment updater
└── create_environment.sh        # Create whole environment
└── README.md                    # Project description (How to run)   
```

---

## Repository Information

- **Repository URL:** https://github.com/n-elie7/submission_reminder_app_n-elie7.git
- **Repository Owner:** n-elie7
- **Project Name:** submission_reminder_app_n-elie7

---

**Need to start over?** Simply delete the application directory and run the setup script again:
```bash
cd ..
rm -rf submission_reminder_{yourName}
./create_environment.sh
```

---

<div align="center">

### Thank You! 🙏

</div>