Capistrano::Configuration.instance.load do

  set :application, "early_years"
  set :repository, "git://github.com/mblwhoi/mblwhoi_library_legacy_early_years"
  set :symlink_to, "#{docroot_dir}/early_years"

end

