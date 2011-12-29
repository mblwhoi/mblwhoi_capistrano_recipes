#!/bin/bash

# path to this dir.
script_dir="$( cd "$( dirname "$0" )" && pwd )"

# Run the set_wysiwyg_settings script w/in the Drupal context.
drush scr "$script_dir/set_wysiwyg_settings.php"