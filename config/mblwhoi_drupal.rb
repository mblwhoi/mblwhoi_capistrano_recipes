# MBLWHOI Drupal tasks.
namespace :mblwhoi_drupal do
  
  desc "Symlinking for Drupal shared resources."
  task :symlink do

    # Symlink drupal default sites folder.
    run "ln -nfs #{shared_path}/sites/default #{release_path}/sites/default"

    # Symlink current release to current path
    run "ln -nsf #{latest_release} #{current_path}"

    # Symlink drupal_root of current release to symlink_to.
    run "ln -nsf #{current_path}/drupal_root #{symlink_to}"

  end # task :symlink
  
  desc "Run drupal migrations."
  task :migrate do

    # Detect new migrations since the last commit.
    run "cd #{deploy_to}/current/drupal_root; git diff --name-status @{1} migrations | grep ^A" do |ch, stream, data|

      # If there were new files...
      if stream == :out

        # For each file status line...
        data.each_line do |line|
          
          # Trim newlines.
          line.chomp!

          # Split the line into status and file
          if (line =~ /^A\s+(.*)/)
            
            filename = $1
            
            # Run the migration.
            run "cd #{deploy_to}/current; \"#{filename}\""
            
          end # if (line =~ ...

        end # data.each_line

      end # if stream == :out

    end # run "cd ...

  end # task :migrate


  desc "Import db dump via drush."
  task :import_db_dump do

    # If local dump file was not given on command line, exit with error.
    if (! exists?(:local_dump_file))
      raise Error, "No local dump file given.  Use command line switch -S local_dump_file=path"
    end

    # Make a unique name for the dump file on the target server by
    # appending the process id of this process.
    dumpfile_basename = File.basename("#{:local_dump_file}")
    tmp_dumpfile_path = "/tmp/#{dumpfile_basename}.#{$$}"

    # Upload the dump file.
    upload(local_dump_file, "#{tmp_dumpfile_path}", :via => :scp)

    # Import the dump on the target server.
    run "cd #{deploy_to}/current/drupal_root; `drush sql-connect` < #{tmp_dumpfile_path}"

    # Remove the temporary dump file on the target server.
    run "rm #{tmp_dumpfile_path}"
    
  end # task : import_db_dump


  desc "Run script from top-level dir."
  task :run_script do

    # If script dir was not given on command line, exit with error.
    if (! exists?(:script_dir))
      raise Error, "No script_dir given.  Use command line switch -S script_dir=path"
    end

    # Make a unique name for the script diron the target server by
    # appending the process id of this process.
    script_dir_basename = File.basename("#{:script_dir}")
    tmp_script_dir_path = "/tmp/#{script_dir_basename}.#{$$}"

    # Upload the script dir.
    upload(script_dir, "#{tmp_script_dir_path}", :via => :scp, :recursive => true)

    # Run the script on the target server from the  dir.
    # The script is presumed to be the file 'script.sh'
    run "cd #{deploy_to}/current/drupal_root; #{tmp_script_dir_path}/script.sh"

    # Remove the temporary script dir on the target server.
    if "#{tmp_script_dir_path}".length > 0
      run "rm -rf #{tmp_script_dir_path}"
    end

  end # task :run_script



  # Define custom deployment process.
  namespace :deploy do

    desc "Deploys mblwhoi drupal app"
    task :default do
      transaction do

        # Update code.
        update_code

        # Do custom symlinking for Drupal.
        mblwhoi_drupal.symlink
      end
    end
    
    task :update_code, :except => { :no_release => true } do
      on_rollback { run "rm -rf #{release_path}; true" }
      strategy.deploy!
    end
    
  end # namespace :deploy

end # namespace :mblwhoi_drupal
