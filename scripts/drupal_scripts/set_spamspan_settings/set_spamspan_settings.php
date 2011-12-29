<?php

// Directory which holds this script.
$script_dir = dirname(__FILE__);

// Check if required modules are installed.
$required_modules = array('spamspan');
foreach ($required_modules as $required_module){
  if (! module_exists($required_module) ){
    die("module '$required_module' is required, but is not enabled, exiting.\n");
  }
}

require_once(drupal_get_path('module', 'filter') . "/filter.admin.inc");

global $user;
$user->uid = 1;

// Make list of filter formats for which we want to do email encoding.
$filters_to_use_spamspan = array(
                                'Filtered HTML' => 1,
                                'Full HTML' => 1,
                               );

// Get filter formats.
$formats = filter_formats();

// For each format...
foreach ($formats as $format_id => $format){

  // Skip the format if it's not in the list.
  if (! isset($filters_to_use_spamspan[$format->name])){
    print "Skipping format '" . $format->name . "'\n";
    continue;
  }


  $roles = array();
  foreach ( explode(',', $format->roles) as $rid){
    if ($rid){
      $roles[$rid] = true;
    }
  }

  $all = filter_list_all();
  $enabled = filter_list_format($format->format);

  $filters = array();
  foreach ($all as $filter_id => $filter) {
    $filters[$filter_id] = isset($enabled[$filter_id]);
  }

  // If spamsan has not been set yet, set it.
  $filters['spamspan/0'] = 1;

  $form_state = array();
  $form_state['values'] = array( 
                                'default_format' => 1, 
                                'name' => $format->name, 
                                'roles' => $roles,
                                'filters' => $filters,
                                'format' => $format->format, 
                                'op' => 'Save configuration',
                                'submit' => 'Save configuration',
                                'form_id' => 'filter_admin_format_form'
                                 );


  print "Setting spamsan for format '" . $format->name . "'\n";
  filter_admin_format_form_submit(array(), $form_state);

}


?>