Capistrano::Configuration.instance.load do

  set :application, "science_is_we"
  set :repository, "git://github.com/mblwhoi/mblwhoi_library_legacy_science_is_we"
  set :symlink_to, "#{docroot_dir}/science_is_we"

end

