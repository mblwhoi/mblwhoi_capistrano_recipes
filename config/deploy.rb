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

# Set branch.
set(:branch, 'master') unless exists?(:branch)

# Set deploy_to.  apps_dir is typically set in stage files.
set (:deploy_to) { "#{apps_dir}/#{application}" }

# Custom tasks namespace.
namespace :mblwhoi do

  desc "test"
  task :test2 do
    puts "app is: #{application}"
  end

  # Task for copying files to a path relative to the shared directory root.
  desc "Copy to path in shared folder"
  task :scp_to_shared do

    # Raise errors if params were not given.
    if (! exists?(:local_path) || ! exists?(:target_path))
      raise Error, "Both 'local_path' and 'target_path' must be provided.  Use command line switch -S e.g. '-S local_path=my_local_path -S target_path=path/relative/to/shared'"
    end

    # Make a unique name for the dump file on the target server by
    # appending the process id of this process.
    dumpfile_basename = File.basename("#{local_path}")
    tmp_dumpfile_path = "/tmp/#{dumpfile_basename}.#{$$}"

    # Generate destination path on remote host.
    destination_path = "#{deploy_to}/shared/#{target_path}"

    # Upload the dump file.
    upload("#{local_path}", tmp_dumpfile_path, :via => :scp, :recursive => true)

    # Grant ownership to web group if indicated.
    if (exists?(:grant_web_group) && exists?(:web_group))
      run "chown -R #{user}:#{web_group} #{tmp_dumpfile_path}"
    end

    # Move dumpfile to destination path via rsync.
    run "rsync -a #{tmp_dumpfile_path}/ #{destination_path}"

  end

end # namespace :mblwhoi
