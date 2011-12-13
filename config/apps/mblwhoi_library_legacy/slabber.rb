Capistrano::Configuration.instance.load do

  set :application, "slabber"
  set :repository, "git://github.com/mblwhoi/mblwhoi_library_legacy_slabber"
  set :symlink_to, "#{docroot_dir}/slabber"

end

