This repository contains resources for MBLWHOI capistrano recipes designed to work work with infrastructure conventions for MBLWHOI Library websites.

= Dependencies
 * railsless-deploy


= Nomenclature

In general this Capistrano setup is used to deploy an 'app' to a 'stage'.

An 'app' can be thought of as the configuration for a single website.  For example, the MBLWHOI Library Homepage is a Drupal app.

A 'stage' can be thought of as the configuration for using hosting environment.  This usually corresponds to a virtual host.  For example, the virtual host environment for 'www.mblwhoilibrary.org' on the production server could be considered the production stage for the MBLWHOI Library website.

A stage can host multiple apps.  The same app can be hosted on multiple stages.

In practice there are usually testing stages and production stages.  Testing stages are used for development and testing new features.  Production stages host the live applications.


= Dynamically Loading Settings

The file 'config/deploy.rb' loads settings from stage and app files which are specified on the command line.  

A stage file represents a destination server and its deployment configurations. Stage configurations are stored in the 'config/stages' dir.  See config/states/example_stage.rb .

An app file represents an application's name (and thus destination folder), source repo, and symlink target.  See config/apps/example_app.rb .

The 'stage' and 'app' files to be used are are indicated via '-S' flags on the command line.  This allows for dynamic loading of settings.


= List of Defined Tasks

The file 'config/deploy.rb' defines a custom task for uploading a directory to a server:
  * mblwhoi:scp_to_shared: uploads a directory specified on the command line to the specified stage.


The file 'config/mblwhoi_drupal.rb' defines several custom tasks specific to MBLWHOI drupal apps:

  * mblwhoi_drupal:deploy: deploy an MBLWHOI Drupal app according to the conventions defined in the https://github.com/mblwhoi/mblwhoi_cookbooks/tree/master/mblwhoi_drupal_app chef recipe.  This task pulls the application code from a git repository, and creates symlinks to static files that should persist between deployments.

  * mblwhoi_drupal:mport_db_dump: import a MySQL database dump into a Drupal app's database.

  * mblwhoi_drupal:run_script: run a script from the top-level directory of a Drupal app.  This can be used for various tasks.


The file 'config/mblwhoi_static.rb' defines several custom tasks specific to MBLWHOI static apps:

  * mblwhoi_drupal:deploy: deploy an MBLWHOI static app.


= Use Examples

Say we have the following directory structure:

mblwhoi_capistrano_recipes/
  Capfile
  config/
    apps/
      mblwhoi_dla/
        dla_cruises.rb
    stages/
      mblwhoi_dla/
        testing_mblwhoi_dla.rb
        production_mblwhoi_dla.rb
  scripts/
    drupal_scripts/
      clear_cache/
        script.sh

To deploy the app defined in 'dla_cruises.rb' to the MBLWHOI DLA testing environment, I would run this command:

'cap mblwhoi_drupal:deploy -S app=mblwhoi_dla/dla_cruises -S stage=mblwhoi_dla/testing_mblwhoi_dla'


The run the script defined in 'clear_cache/script.sh' from the top-level drupal folder of the DLA cruises app, I would run this command:

'cap mblwhoi_drupal:run_script -S app=mblwhoi_dla/dla_cruises -S stage=mblwhoi_dla/testing_mblwhoi_dla -S script_dir=scripts/drupal_scripts/clear_cache'



