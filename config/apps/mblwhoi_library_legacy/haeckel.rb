Capistrano::Configuration.instance.load do

  set :application, "haeckel"
  set :repository, "git://github.com/mblwhoi/mblwhoi_library_legacy_haeckel"
  set :symlink_to, "#{docroot_dir}/haeckel"

end

