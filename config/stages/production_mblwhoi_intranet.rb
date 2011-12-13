Capistrano::Configuration.instance.load do

  set :domain, "128.128.164.132"

  server domain, :app, :web, :db, :primary => true

  set :user, "deploy"
  set :use_sudo, false

  set :apps_dir, "/data/www/intranet.mblwhoilibrary.org/apps"
  set :docroot_dir, "/data/www/intranet.mblwhoilibrary.org/htdocs"
  
  set :web_group, "www-data"

end
