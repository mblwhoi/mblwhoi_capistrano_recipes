# MBLWHOI Static App Tasks.
namespace :mblwhoi_static do
  
  desc "Symlinking for static apps."
  task :symlink do

    # Symlink current release to current path
    run "ln -nsf #{latest_release} #{current_path}"

    # Symlink current release to symlink_to.
    run "ln -nsf #{current_path} #{symlink_to}"

  end # task :symlink


  # Define custom deployment process.
  namespace :deploy do

    desc "Deploys mblwhoi static app"
    task :default do
      transaction do

        # Update code.
        update_code

        # Do custom symlinking for mblwhoi_static.
        mblwhoi_static.symlink
      end
    end
    
    task :update_code, :except => { :no_release => true } do
      on_rollback { run "rm -rf #{release_path}; true" }
      strategy.deploy!
    end
    
  end # namespace :deploy

end # namespace :mblwhoi_static
