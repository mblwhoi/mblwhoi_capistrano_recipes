Capistrano::Configuration.instance.load do

  set :domain, "vagrant"

  server domain, :app, :web, :db, :primary => true

  set :user, "vagrant"
  set :use_sudo, false

  set :branch, "devel"

  set :apps_dir, "/data/www/legacy.mblwhoilibrary.org/apps"
  set :docroot_dir, "/data/www/legacy.mblwhoilibrary.org/htdocs"
  
  set :web_group, "www-data"

end
