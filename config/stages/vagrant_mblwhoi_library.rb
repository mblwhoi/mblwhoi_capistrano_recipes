Capistrano::Configuration.instance.load do

  set :domain, "dev.mblwhoilibrary.org"

  server domain, :app, :web, :db, :primary => true

  set :user, "vagrant"
  set :use_sudo, false

  set :apps_dir, "/data/www/mblwhoilibrary.org/apps"
  set :docroot_dir, "/data/www/mblwhoilibrary.org/htdocs"
  
  set :web_group, "www-data"

end
