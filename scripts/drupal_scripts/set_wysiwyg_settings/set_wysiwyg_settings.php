<?php

// Directory which contains this script.
$script_dir = dirname(__FILE__);

// Check if required modules are installed.
$required_modules = array('wysiwyg','imce','imce_mkdir','imce_wysiwyg');
foreach ($required_modules as $required_module){
  if (! module_exists($required_module) ){
    die("module '$required_module' is required, but is not enabled, exiting.\n");
  }
}

// Check if ckeditor library is installed.
$ckeditor_library_path = 'sites/all/libraries/ckeditor/ckeditor.js';
if (! file_exists($ckeditor_library_path)){
  die("Library '$ckeditor_library_path' is required, but is not installed, exiting.\n");  
 }

require_once(drupal_get_path('module', 'wysiwyg') . "/wysiwyg.admin.inc");
require_once(drupal_get_path('module', 'imce') . "/inc/imce.admin.inc");
require_once(drupal_get_path('module', 'user') . "/user.module");



global $user;
$user->uid = 1;

/**
 * Set CKEditor settings.
 **/

// Make list of filter formats for which we want to use ckeditor.
$formats_to_use = array(
                         'Full HTML' => 1,
                         );
// For each format...
// Get filter formats.
$formats = filter_formats();

// For each format...
foreach ($formats as $format_id => $format){

  // Skip the format if it's not in the list.
  if (! isset($formats_to_use[$format->name])){
    print "Skipping format '" . $format->name . "'\n";
    continue;
  }

  // Add editor/format pairing to db.
  db_query("UPDATE {wysiwyg} SET editor = '%s' WHERE format = %d", 'ckeditor', $format_id);
  if (!db_affected_rows()) {
    db_query("INSERT INTO {wysiwyg} (format, editor) VALUES (%d, '%s')", $format_id, 'ckeditor');
  }


  // Create a simulated form array.
  $form_state = array();

  $form_state['values'] = array (
  'format' => $format_id,
  'input_format' => $format->name,
  'editor' => 'ckeditor',
  'default' => 1,
  'user_choose' => 0,
  'show_toggle' => 1,
  'theme' => 'advanced',
  'language' => 'en',
  'buttons' => 
  array (
    'default' => 
    array (
      'Bold' => 1,
      'Italic' => 1,
      'Underline' => 1,
      'Strike' => 1,
      'JustifyLeft' => 1,
      'JustifyCenter' => 1,
      'JustifyRight' => 1,
      'JustifyBlock' => 1,
      'BulletedList' => 1,
      'NumberedList' => 1,
      'Outdent' => 1,
      'Indent' => 1,
      'Undo' => 1,
      'Redo' => 1,
      'Link' => 1,
      'Unlink' => 1,
      'Anchor' => 1,
      'Image' => 1,
      'TextColor' => 1,
      'BGColor' => 1,
      'Superscript' => 1,
      'Subscript' => 1,
      'Blockquote' => 1,
      'Source' => 1,
      'HorizontalRule' => 1,
      'Cut' => 1,
      'Copy' => 1,
      'Paste' => 1,
      'PasteText' => 1,
      'PasteFromWord' => 1,
      'ShowBlocks' => 1,
      'RemoveFormat' => 1,
      'SpecialChar' => 1,
      'Format' => 1,
      'Font' => 1,
      'FontSize' => 1,
      'Styles' => 1,
      'Table' => 1,
      'SelectAll' => 1,
      'Find' => 0,
      'Replace' => 0,
      'Flash' => 0,
      'Smiley' => 0,
      'CreateDiv' => 1,
      'Maximize' => 1,
      'SpellChecker' => 1,
      'Scayt' => 1,
      'About' => 0,
    ),
    'imce' => 
    array (
      'imce' => 1,
    ),
    'drupal' => 
    array (
      'break' => 0,
    ),
  ),
  'toolbar_loc' => 'top',
  'toolbar_align' => 'left',
  'path_loc' => 'bottom',
  'resizing' => 1,
  'verify_html' => 1,
  'preformatted' => 0,
  'convert_fonts_to_spans' => 1,
  'remove_linebreaks' => 1,
  'apply_source_formatting' => 1,
  'paste_auto_cleanup_on_paste' => 1,
  'block_formats' => 'p,address,pre,h3,h4,h5,h6,div',
  'css_setting' => 'theme',
  'css_path' => '',
  'css_classes' => '',
  'op' => 'Save',
  'submit' => 'Save',
  'form_id' => 'wysiwyg_profile_form',
                                 );
  print "Setting ckeditor for format '" . $format->name . "'\n";

  wysiwyg_profile_form_submit(array(), $form_state);

}



/**
 * Set IMCE Settings
 **/


// Create a simulated form array.
$form_state = array();

// Create imce profile.
$form_state['values'] = array( 
                              'profile' => 
                              array (
                                     'name' => time(),
                                     'usertab' => 0,
                                     'filesize' => '0',
                                     'quota' => '0',
                                     'tuquota' => '0',
                                     'extensions' => '*',
                                     'dimensions' => '800x600',
                                     'filenum' => '0',
                                     'directories' => 
                                     array (
                                            0 => 
                                            array (
                                                   'name' => '.',
                                                   'subnav' => 1,
                                                   'browse' => 1,
                                                   'upload' => 1,
                                                   'thumb' => 1,
                                                   'delete' => 1,
                                                   'resize' => 1,
                                                   'mkdir' => 1,
                                                   'rmdir' => 1,
                                                   ),
                                            1 => 
                                            array (
                                                   'name' => '',
                                                   'subnav' => 0,
                                                   'browse' => 0,
                                                   'upload' => 0,
                                                   'thumb' => 0,
                                                   'delete' => 0,
                                                   'resize' => 0,
                                                   'mkdir' => 0,
                                                   'rmdir' => 0,
                                                   ),
                                            2 => 
                                            array (
                                                   'name' => '',
                                                   'subnav' => 0,
                                                   'browse' => 0,
                                                   'upload' => 0,
                                                   'thumb' => 0,
                                                   'delete' => 0,
                                                   'resize' => 0,
                                                   'mkdir' => 0,
                                                   'rmdir' => 0,
                                                   ),
                                            ),
                                     'thumbnails' => 
                                     array (
                                            0 => 
                                            array (
                                                   'name' => 'Thumb',
                                                   'dimensions' => '90x90',
                                                   'prefix' => 'thumb_',
                                                   'suffix' => '',
                                                   ),
                                            1 => 
                                            array (
                                                   'name' => '',
                                                   'dimensions' => '',
                                                   'prefix' => '',
                                                   'suffix' => '',
                                                   ),
                                            2 => 
                                            array (
                                                   'name' => '',
                                                   'dimensions' => '',
                                                   'prefix' => '',
                                                   'suffix' => '',
                                                   ),
                                            ),
                                     'mkdirnum' => '0',
                                     ),
                              'pid' => "$pid",
                              'op' => 'Save configuration',
                              'submit' => 'Save configuration',
                              'form_id' => 'imce_profile_form',
                               );

imce_profile_submit(array(), $form_state);

// Get the new pid if pid was not set (should be the last profile).
$imce_profiles = variable_get('imce_profiles', array());
if (isset($imce_profiles)) {
  $pid = ($pid && isset($imce_profiles[$pid])) ? $pid : count($imce_profiles);
 }


// Make list of roles which will use imce profile.
$imce_roles = array('dla admin','dla editor');

// Get User roles.
$user_roles = array();
$result = db_query('SELECT * FROM {role} ORDER BY name');
while ($role = db_fetch_object($result)){
  $user_roles[$role->name] = $role;
 }


# Get current imce role config.
$imce_role_config = variable_get('imce_roles_profiles', array());

// Set imce profile for roles listed above.
foreach ($imce_roles as $r){
  $imce_role_config[$user_roles[$r]->rid] = array(
                                                  'weight' => '0',
                                                  'pid' => "$pid"
                                                  );
}

// Save the modified roles.
variable_set('imce_roles_profiles', $imce_role_config);

?>