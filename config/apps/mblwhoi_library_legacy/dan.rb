Capistrano::Configuration.instance.load do

  set :application, "dan"
  set :repository, "git://github.com/mblwhoi/mblwhoi_library_legacy_dan"
  set :symlink_to, "#{docroot_dir}/dan"

end

