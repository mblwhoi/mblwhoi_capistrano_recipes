Capistrano::Configuration.instance.load do

  set :domain, "dev.cruises.whoi.edu"

  server domain, :app, :web, :db, :primary => true

  set :user, "vagrant"
  set :use_sudo, false

  set :branch, "master"

  set :apps_dir, "/data/www/dla.whoi.edu/apps"
  set :docroot_dir, "/data/www/dla.whoi.edu/htdocs"
  
  set :web_group, "www-data"

end
