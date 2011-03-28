# This is a generic capistrano recipe that loads configuration variables from both 'stage' files and 'app' files.  
# 'stage' and 'app' files must be specified on the command line using the '-S' (uppercase) flag.
# Variables can be overriden by using the '-s' (lowercase) flag on the command line.

# Load stage settings.
# By convention, stage settings are in config/stages/my_stage_name.rb
if (! exists?(:stage))
  raise Error, "No stage given.  Use command line switch -S stage=my_stage_name . Stage settings file must exist in config/stages e.g. config/apps/my_stage_name.rb"
end
stage_settings_file = File.expand_path(File.dirname(__FILE__) + "/stages/#{stage}")
require "#{stage_settings_file}"

# Load application settings.
# By convention, app settings are in config/apps/my_app_name.rb
if (! exists?(:app))
  raise Error, "No app given.  Use command line switch -S app=my_app_name . App settings file must exist in config/apps e.g. config/apps/my_app_name.rb"
end
app_settings_file = File.expand_path(File.dirname(__FILE__) + "/apps/#{app}")
require "#{app_settings_file}"

# Set default scm settings.
set :scm, :git
set :git_enable_submodules, true

# Set deploy_to.  apps_dir is typically set in stage files.
set (:deploy_to) { "#{apps_dir}/#{application}" }


