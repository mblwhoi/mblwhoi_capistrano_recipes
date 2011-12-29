#!/bin/bash

# path to this dir.
script_dir="$( cd "$( dirname "$0" )" && pwd )"

# Run the activiate spamspan script.
drush scr "$script_dir/set_spamspan_settings.php"