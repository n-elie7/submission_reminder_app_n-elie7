#!/bin/bash

# Ask user for their name
echo -n "Please enter your name: "
read -r name

# Check if the name is not empty string
if [ -z "$name" ]; then
    echo "Error: Name cannot be empty!"
    exit 1
fi

# Creating main_dir which is submission_reminder_{name}
submission_dir="submission_reminder_${name}"

if [ -d "$submission_dir" ]; then
    # Ask if they want to overwrite if the script is being run many times 
    echo "Warning: Directory already exists. Do you want to overwrite it? (y/n)"
    read -p "Choice: " choice

    if [ "$choice" != "y" ]; then
        echo "Setup cancelled."
        exit 0
    fi
    rm -rf "$submission_dir"
fi

mkdir -p "$submission_dir"

# Creating subdirectories
mkdir -p "$submission_dir/app"
mkdir -p "$submission_dir/modules"
mkdir -p "$submission_dir/assets"
mkdir -p "$submission_dir/config"

# Adding file for those subdirectories

# Creating & Adding content for config.env

echo "Creating config.env..."

cat > "$submission_dir/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

echo "config.env file created successfully"

# Creating & Adding content for functions.sh

echo "Creating functions.sh..."

cat > "$submission_dir/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

echo "functions.sh file created successfully"

# Creating & Adding content of reminder.sh file
echo "Creating reminder.sh..."

cat > "$submission_dir/app/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

echo "reminder.sh file created successfully"

# Creating & Adding content of submissions.txt file with sample data and 5 additional records
echo "Creating submissions.txt..."

cat > "$submission_dir/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Emmanuel, Docker Basics, submitted
Grace, Linux Commands, not submitted
Isaac, Python Scripting, pending
Jennifer, Database Design, submitted
Kevin, Web Development, not submitted
Linda, API Integration, submitted
Moses, Cloud Computing, pending
Nancy, Cybersecurity, submitted
Oliver, DevOps Tools, not submitted
Patricia, Kubernetes, submitted
EOF

echo "submissions.txt file created successfully"

# Creating startup.sh file

echo "Creating startup.sh"

cat > "$submission_dir/startup.sh" << 'EOF'
#!/bin/bash

# Running Submission Reminder App
echo "Starting submission reminder app"

# Get the directory where this script is located
submission_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if app directory exists
if [ ! -d "$submission_dir/app" ]; then
    echo "Error: Application directory not found!"
    exit 1
fi

# Check if reminder.sh script exists
reminder_file="$submission_dir/app/reminder.sh"

if [ ! -f "$reminder_file" ]; then
    echo "Error: reminder.sh script not found!"
    exit 1
fi


# Run the reminder application
echo "Loading reminder application..."
echo

# Change to $submission_dir first for reminder.sh
# To find functions.sh & config.env
# This will solve an error "No such file or directory" for those files

cd "$submission_dir"

# Execute the reminder.sh script
bash $reminder_file

# Check exit status to determine if it succeed or not.
if [ $? -eq 0 ]; then
    echo
    echo "Application completed successfully."
else
    echo
    echo "Application encountered an error."
    exit 1
fi
EOF

echo "startup.sh file created successfully"

# Make script files executable
chmod +x $submission_dir/app/*.sh
chmod +x $submission_dir/modules/*.sh
chmod +x $submission_dir/*.sh