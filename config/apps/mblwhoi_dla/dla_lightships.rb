Capistrano::Configuration.instance.load do

  set :application, "dla_lightships"
  set :repository, "git://github.com/mblwhoi/dla_lightships.git"
  set :symlink_to, "#{docroot_dir}/lightships"

end

