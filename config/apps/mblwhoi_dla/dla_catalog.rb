Capistrano::Configuration.instance.load do

  set :application, "dla_catalog"
  set :repository, "git://github.com/mblwhoi/dla_catalog.git"
  set :symlink_to, "#{docroot_dir}/catalog"

end

