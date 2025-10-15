#!/bin/bash

# This script updates the assignment name in config.env and reruns the application

# Get the directory where this config.env is located
submission_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define the path to config.env & startup.sh files
config_file="$(find "$submission_dir" -type f -path "*/config/config.env" | head -n 1)"
startup_file="$(find "$submission_dir" -type f -name "startup.sh" | head -n 1)"

# Check if config file exists
if [ ! -f "$config_file" ]; then
    echo "Error: Config file is not found at $config_file"
    echo "Please make sure you're running this script from the submission_reminder directory"
    exit 1
fi

# Asking user for new assignment name
read -p "Enter the new assignment name: " new_assignment

# Validate input
if [ -z "$new_assignment" ]; then
    echo "Error: Assignment name cannot be empty!"
    exit 1
fi

echo
echo "Updating assignment in configuration file..."

# Use sed to replace the ASSIGNMENT value in config.env
sed -i "" "s|^ASSIGNMENT=.*|ASSIGNMENT=\"$new_assignment\"|" "$config_file"

# Check if sed was successful
if [ $? -eq 0 ]; then
    echo "Configuration updated successfully!"
    echo "New Assignment: $new_assignment"
else
    echo "Error: Failed to update configuration file"
    exit 1
fi

echo "Restarting Application / rerun startup.sh"

# Check if startup.sh exists
if [ ! -f "$startup_file" ]; then
    echo "Error: startup.sh not found!"
    exit 1
fi

# Run the startup script
bash $startup_file

echo "  Configuration Update Complete"