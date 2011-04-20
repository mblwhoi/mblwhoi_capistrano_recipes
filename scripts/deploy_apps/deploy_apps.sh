#!/bin/bash

# path to this dir.
script_dir="$( cd "$( dirname "$0" )" && pwd )"

# app namespace
app_ns=$1

# stage
stage=$2

# db dump files dir
db_dir="$script_dir/$app_ns/db_dumps"

# file dumps dir
files_dir="$script_dir/$app_ns/file_dumps"

# capistrano root dir.
cap_root="$script_dir/../.."

# clear cache script dir
clear_cache_script_dir="$cap_root/scripts/drupal_scripts/clear_cache"

cd $cap_root;

# Deploy drupal sites.
for app_name in `cat "$script_dir/$app_ns/${app_ns}_drupal_apps.txt"`;
do

    CMD="$script_dir/deploy_drupal_app.sh $app_ns $stage $app_name"
    $CMD

done;
