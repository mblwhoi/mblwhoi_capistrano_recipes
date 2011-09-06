#!/bin/bash

# path to this dir.
script_dir="$( cd "$( dirname "$0" )" && pwd )"

# app namespace
app_ns=$1

# stage
stage=$2

# app id
app_name=$3

# db dump files dir
db_dir="$script_dir/$app_ns/db_dumps"

# file dumps dir
files_dir="$script_dir/$app_ns/file_dumps"

# capistrano root dir.
cap_root="$script_dir/../.."

# clear cache script dir
clear_cache_script_dir="$cap_root/scripts/drupal_scripts/clear_cache"

# change to capistrano root.
cd $cap_root;

# Set app id.
app_id="$app_ns/$app_name"

# Deploy app code.
cap mblwhoi_drupal:deploy -S stage=$stage -S app=$app_id

# Synch app's db.
cap mblwhoi_drupal:import_db_dump -S stage=$stage -S app=$app_id -S local_dump_file=$db_dir/$app_name.sql

# Synch app's files.
cap mblwhoi:scp_to_shared -S stage=$stage -S app=$app_id -S local_path=$files_dir/$app_name.files -S target_path=sites/default/files -S grant_web_group=true; chmod -R g+w

# Run clear cache script.
cap mblwhoi_drupal:run_script -S stage=$stage -S app=$app_id -S script_dir=$clear_cache_script_dir

