#!/bin/bash

read -p "Enter your name:" name

#Making the directory
dir_name="submission_reminder_$name"
mkdir -p "$dir_name"
cd "$dir_name"

#Making the internal directories
mkdir -p app modules assets config
cd app

cat > "reminder.sh" << 'EOL'
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

check_submissions "$submissions_file"
EOL

chmod u+rwx reminder.sh

cd ..
cd modules

cat > "functions.sh" << 'EOL'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file ..."
    echo "--------------------------------------------------"
    echo "SHELL NAVIGATION LIST OF STUDENTS AND THEIR STATUS"
    echo "--------------------------------------------------"
    echo "STUDENT                              ASSIGNMENT                     STATUS"
    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)
        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "$student                     $ASSIGNMENT                    NOT SUBMITTED"
 	else 
	    if [[ "assignment" == "$ASSIGNMENT" ]]; then
	    	echo "$student                             $assignment            SUBMITTED"
	    else
	    	if [[ "$status" == "not submitted" ]]; then
			echo "$student                              $assignment          NOT SUBMITTED"
		else
			echo "$student                             $assignment          SUBMITTED"
		fi
	    fi
	fi 
    done < <(tail -n +2 "$submissions_file") # Skip the header
    echo "----------------------------------------"
    echo "SUMMARY FOR SHELL NAVIGATION"
    echo "----------------------------------------"
    while IFS=, read -r student assignment status; do
	student=$(echo "$student" | xargs)
	assignment=$(echo "$assignment" | xargs)
	status=$(echo "$status" | xargs)
	if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
    		echo "$student has not yet submitted the $ASSIGNMENT"
    	fi
    done < <(tail -n +2 "$submissions_file") 
}
EOL

chmod u+rwx functions.sh

cd ..
cd assets

cat > "submissions.txt" << 'EOL'
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
EOL

cd ..
cd config

cat > "config.env" << 'EOL'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

cd ..

cat > "startup.sh" << 'EOL'
clear
echo "--------------------------------------------"
echo "   WELCOME TO THE SUBMISSION REMINDER APP   "
echo "--------------------------------------------"
while true; do
	read -p "Press 1 to get all the reminders or Ctrl + C to quit: " response
	if [ "$response" == "1" ]; then
		echo "--------------------------------------------"
		./app/reminder.sh
        	echo "--------------------------------------------"
	else
		echo "Wrong option! Please read instructions!"
	fi
done
EOL

chmod u+rwx startup.sh

./startup.sh
