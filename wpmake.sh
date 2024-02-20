#!/bin/bash

# MySQL root credentials
DB_USER="root"
DB_PASS="root"


# Ask for a directory name
read -p "Enter the directory name for WordPress installation: " DIR_NAME

# Define the installation directory
INSTALL_DIR=~/sites/$DIR_NAME

# Check if directory already exists
if [ -d "$INSTALL_DIR" ]; then
    echo "Directory $INSTALL_DIR already exists. Please choose a different name or remove the existing directory."
    exit 1
fi

# Create the directory and change to it
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Use directory name as the database name
DB_NAME=$(echo $DIR_NAME | tr -cd '[:alnum:]' | tr '[:upper:]' '[:lower:]')

# MySQL command to create the database
mysql -u $DB_USER -p$DB_PASS -e "CREATE DATABASE $DB_NAME;"

# Secure the site using Valet with HTTPS
valet secure

# Check if WordPress files are already present
if [ -f "wp-config.php" ]; then
    echo "WordPress files are already present in this directory."
else
    # Download WordPress core files
    wp core download
fi

# Set site name, admin username, and password
SITE_NAME="My WordPress Site"
ADMIN_USER="admin"
ADMIN_PASS="admin"

# Create wp-config.php using wp config create
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=localhost --extra-php <<PHP
define( 'WP_DEBUG', false );
define( 'WP_DEBUG_DISPLAY', false );
PHP

# Install WordPress
wp core install --url=https://$DIR_NAME.test --title="$SITE_NAME" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email=admin@example.com

# Open the directory in Visual Studio Code
if [[ "$1" == "-v" ]]; then
    # code $INSTALL_DIR
fi


# Open the login page with pre-filled username and password
if [[ "$1" == "-w" ]]; then
	open "https://$DIR_NAME.test/wp-login.php?username=$ADMIN_USER&password=$ADMIN_PASS"
fi

# Provide a message indicating the process is complete
echo "WordPress installation and database creation complete. Your site is now secured with HTTPS in $INSTALL_DIR. Visual Studio Code is now open for editing. The login page is also opened in your default web browser with pre-filled username and password."
