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
for da in `cat "$script_dir/$app_ns/${app_ns}_drupal_apps.txt"`;
do
    app_id="$app_ns/$da"

    cap mblwhoi_drupal:import_db_dump -S stage=$stage -S app=$app_id -S local_dump_file=$db_dir/$da.sql

    cap mblwhoi:scp_to_shared -S stage=$stage -S app=$app_id -S local_path=$files_dir/$da.files -S target_path=sites/default/files -S grant_web_group=true

    cap mblwhoi_drupal:run_script -S stage=$stage -S app=$app_id -S script_dir=$clear_cache_script_dir

done;
