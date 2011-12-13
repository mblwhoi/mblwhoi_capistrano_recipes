Capistrano::Configuration.instance.load do

  set :application, "dla_cruises"
  set :repository, "git://github.com/mblwhoi/dla_cruises.git"
  set :symlink_to, "#{docroot_dir}/cruises"

end

