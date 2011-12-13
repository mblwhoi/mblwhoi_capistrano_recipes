Capistrano::Configuration.instance.load do

  set :application, "mblwhoi_intranet"
  set :repository, "git://github.com/mblwhoi/mblwhoi_intranet_home.git"
  set :symlink_to, "#{docroot_dir}/intranet"

end
