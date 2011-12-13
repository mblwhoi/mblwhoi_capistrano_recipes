Capistrano::Configuration.instance.load do

  set :application, "dla_legacy_cruises"
  set :repository, "git://github.com/mblwhoi/dla_legacy_cruises.git"
  set :symlink_to, "#{docroot_dir}/legacy_cruises"

end

