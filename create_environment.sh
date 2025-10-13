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
main_dir="submission_reminder_${name}"

if [ -d "$main_dir" ]; then
    # Ask if they want to overwrite if the script is being run many times 
    echo "Warning: Directory already exists. Do you want to overwrite it? (y/n)"
    read -p "Choice: " choice

    if [ "$choice" != "y" ]; then
        echo "Setup cancelled."
        exit 0
    fi
    rm -rf "$main_dir"
fi

mkdir -p "$main_dir"

# Creating subdirectories
mkdir -p "$main_dir/app"
mkdir -p "$main_dir/modules"
mkdir -p "$main_dir/assets"
mkdir -p "$main_dir/config"

# Adding file for those subdirectories