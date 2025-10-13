#!/bin/bash

echo -n "Please enter your name: "
read -r name

mkdir -p submission_reminder_"$name"

cd submission_reminder_"$name"

mkdir -p app modules assets config

touch startup.sh

chmod +x startup.sh