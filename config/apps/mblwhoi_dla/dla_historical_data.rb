Capistrano::Configuration.instance.load do

  set :application, "dla_historical_data"
  set :repository, "git://github.com/mblwhoi/dla_historical_data.git"
  set :symlink_to, "#{docroot_dir}/historical_data"

end

