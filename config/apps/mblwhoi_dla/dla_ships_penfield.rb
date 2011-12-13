Capistrano::Configuration.instance.load do

  set :application, "dla_ships_penfield"
  set :repository, "git://github.com/mblwhoi/dla_ships_penfield.git"
  set :symlink_to, "#{docroot_dir}/whoi_ships_by_penfield"

end

