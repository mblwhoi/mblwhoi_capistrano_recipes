Capistrano::Configuration.instance.load do

  set :domain, "my.domain.com"

  server domain, :app, :web, :db, :primary => true

  set :user, "deploy"
  set :use_sudo, false

  set :apps_dir, "/my/apps/dir"
  set :docroot_dir, "/my/docroot/dir"
  
  set :web_group, "www-data"

end
