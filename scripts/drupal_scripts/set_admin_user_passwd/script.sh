#!/bin/sh

# Set the pw for user with uid 1 (usually 'admin')

# This script should be run from the top level of a drupal site.

# Comment out these two lines after you understand the script.
echo "\n\nYOU MUST EDIT AND UNDERSTAND THIS SCRIPT BEFORE YOU RUN IT, EXITING!!!\n\n"
exit 1;

# Change the pass below, comment out the line.
#drush php-eval 'db_query("UPDATE `users` SET `pass` = MD5(\"SOMEPASS") WHERE `uid` =1;");'

# IMPORTANT!!! When you are done with this script, take out the password so that it doesn't get checked into source control,
# and comment out the line so that the next user is forced to edit the script.