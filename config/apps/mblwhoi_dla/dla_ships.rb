Capistrano::Configuration.instance.load do

  set :application, "dla_ships"
  set :repository, "git://github.com/mblwhoi/dla_ships.git"
  set :symlink_to, "#{docroot_dir}/ships"

end

