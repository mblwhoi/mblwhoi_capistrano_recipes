Capistrano::Configuration.instance.load do

  set :application, "dla_whoi_av"
  set :repository, "git://github.com/mblwhoi/dla_whoi_av.git"
  set :symlink_to, "#{docroot_dir}/whoi_av"

end

