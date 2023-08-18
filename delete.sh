#!/bin/bash

# Prompt the user for the prefix
read -p "Enter the prefix to filter directories (e.g., 'my'): " PREFIX

# Set the MySQL user
MYSQL_USER="root"

# Prompt the user for the MySQL password
read -s -p "Enter the MySQL password: " MYSQL_PASSWORD
echo

# Set the MySQL password as an environment variable
export MYSQL_PWD="$MYSQL_PASSWORD"

# Get list of directories starting with the specified prefix inside ~/sites
DIRECTORIES=$(find ~/sites -maxdepth 1 -type d -name "$PREFIX*")

# Loop through the directories and delete databases and directories
for DIR in $DIRECTORIES; do
    # Extract the directory name without the path
    DIR_NAME=$(basename "$DIR")

    # Drop MySQL database using password from environment variable
    mysql -u$MYSQL_USER -s -e "DROP DATABASE IF EXISTS \`$DIR_NAME\`;"

    # Delete the directory
    rm -rf "$DIR"
done

# Unset the MySQL password environment variable
unset MYSQL_PWD

echo "MySQL databases and directories with prefix '$PREFIX' deleted successfully."
