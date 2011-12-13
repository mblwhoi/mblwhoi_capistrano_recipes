Capistrano::Configuration.instance.load do

  set :application, "astrolabe"
  set :repository, "git://github.com/mblwhoi/mblwhoi_library_legacy_astrolabe"
  set :symlink_to, "#{docroot_dir}/astrolabe"

end

