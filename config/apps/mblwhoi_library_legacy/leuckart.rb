Capistrano::Configuration.instance.load do

  set :application, "leuckart"
  set :repository, "git://github.com/mblwhoi/mblwhoi_library_legacy_leuckart"
  set :symlink_to, "#{docroot_dir}/leuckart"

end

