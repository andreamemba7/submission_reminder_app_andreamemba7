# Submission Reminder App

A simple Bash script-based application to track student assignment submissions and send reminders for pending assignments.

## Overview

This application reads a list of students and their assignment submission status from a CSV file, compares it with a configured assignment, and outputs reminders for students who have not submitted yet. It also shows a summary and detailed status of all students.

The app features:

- Interactive menu-driven interface
- Configurable assignment name and submission deadline
- Clear display of submission status for all students
- Easily extensible and customizable

## Prerequisites

- Bash shell (Linux/macOS/Windows with WSL or Git Bash)
- Basic familiarity with terminal commands

## Setup Instructions

1. Clone or Download the Project

   Download or clone the project folder to your local machine.

2. Run the Setup Script

   Open a terminal and run:   ./create_environment.sh

This script will prompt you for your name and create a personalized workspace with all necessary files and folders.

3. Start the Application

   In the terminal, start the app by running:
   ./startup.sh

   However, the previous command will already have this as part of its script

## How to Use

* Upon running `startup.sh`, you will see a welcome message and menu prompt.
* Press `1` to display reminders for students who have not submitted the assignment.
* The app will show:

  * A table listing each student’s submission status.
  * A summary of students who still need to submit.
* Press `Ctrl + C` at any time to exit.

## Configuration

Edit the configuration file to change the assignment name and submission deadline:

	config/config.env

Example contents:

	ASSIGNMENT="Shell Navigation"
	DAYS_REMAINING=2

Modify `ASSIGNMENT` to track different assignments and adjust `DAYS_REMAINING` as needed.

## File Structure

submission_reminder_<your_name>/
├── app/
│   └── reminder.sh          # Main script that runs the reminder logic
├── assets/
│   └── submissions.txt     # CSV file with student submissions data
├── config/
│   └── config.env          # Configuration file for assignment details
├── modules/
│   └── functions.sh        # Functions used by reminder.sh
└── startup.sh              # Entry point script with menu interface

## Example `submissions.txt` Format

student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Andrea, Shell Navigation, not submitted
Ayomide, Git, submitted
Dorcas, Shell Basics, submitted
Nick, Shell Navigation, not submitted
Natasha, Git, submitted

## Permissions

Make sure all scripts have execute permission:

	chmod +x app/reminder.sh modules/functions.sh startup.sh

## Troubleshooting

Files not found errors:
  Ensure you run `create_environment.sh` from the root project directory (`submission_reminder_<your_name>/`).

Permission denied:
  Confirm you gave execute permissions to the scripts as shown above.

Unexpected output or errors:
  Check that the `config/config.env` file is correctly formatted and variables are set.

## License & Credits

Created by andreamemba7
