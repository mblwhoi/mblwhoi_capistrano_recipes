Capistrano::Configuration.instance.load do

  set :application, "mblwhoi_library_home"
  set :repository, "git://github.com/mblwhoi/mblwhoi_library_home.git"
  set :symlink_to, "#{docroot_dir}"

end
