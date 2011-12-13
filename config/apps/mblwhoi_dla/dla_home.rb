Capistrano::Configuration.instance.load do

  set :application, "dla_home"
  set :repository, "git://github.com/mblwhoi/dla_home.git"
  set :symlink_to, "#{docroot_dir}/dla"  

end

