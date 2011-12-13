Capistrano::Configuration.instance.load do

  set :application, "dla_water_temperatures"
  set :repository, "git://github.com/mblwhoi/dla_water_temperatures.git"
  set :symlink_to, "#{docroot_dir}/water_temperatures"

end

