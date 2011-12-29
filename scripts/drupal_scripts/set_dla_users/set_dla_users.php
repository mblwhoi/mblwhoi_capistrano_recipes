<?php

  /**
   * Script to update dla users.
   * Creates roles if they don't exist, creates users if they don't exist, and
   * updates user info.
   */

// Directory which contains this script.
$script_dir = dirname(__FILE__);

// Initialize users array.
$users = array();

// Open handle to users file.
$user_file = $script_dir . '/dla_users.csv';

$handle = fopen($user_file, "r");
if (! $handle){
  die("Error: Unable to open users file '$user_file', exiting.\n");
}

// Read headers.
$headers = fgetcsv($handle);

// Read users.
while($user_row = fgetcsv($handle)){

  // Initialize user array
  $user = array();

  // Save values.
  for ($i = 0; $i < count($headers); $i++){
    $user[$headers[$i]] = $user_row[$i];
  }

  // Save user to list.
  $users[] = $user;
 }


// Get roles.  

// Intialize list of roles.
$roles = array();

// Initialize a role id lookup.
$rid_lookup = array();

// For each user...
foreach ($users as $user){

  // Save the role for each user to the array.
  $roles[$user['role']] = $user['role'];

}


// For each role...
foreach ($roles as $role){
  
  // Skip if the role is blank.
  if (! $role){
    next;
  }

  // Query db for role.
  $result = db_result(db_query("SELECT name FROM {role} WHERE name = '%s'", $role));

  // If the role does not exist...
  if(! $result){

    // Create the role.
    db_query("INSERT INTO {role} (name) VALUES ('%s')", $role);
  }

  // Get the role id
  $rid = db_result(db_query("SELECT rid FROM {role} WHERE name = '%s'", $role));

  // Save the role id to the role id lookup.
  $rid_lookup[$role] = $rid;

}


// For each user...
foreach ($users as $user){

  // Try to load the user.  User obj will be null if could not load.
  $user_obj = user_load(array('name' => $user['user_name']) );

  // Make array of values to update
  $user_array = array(
                      'name' => $user['user_name'],
                      'mail' => $user['email'],
                      'status' => 1,
                      'init' => $user['email'],
                      'roles' => array($rid_lookup[$user['role']] => $user['role'])
                      );
    
  // Update or create the user.
  user_save($user_obj, $user_array);

}



?>