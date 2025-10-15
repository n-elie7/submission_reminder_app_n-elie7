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
