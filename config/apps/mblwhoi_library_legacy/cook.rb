Capistrano::Configuration.instance.load do

  set :application, "cook"
  set :repository, "git://github.com/mblwhoi/mblwhoi_library_legacy_cook"
  set :symlink_to, "#{docroot_dir}/cook"

end

