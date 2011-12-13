Capistrano::Configuration.instance.load do

  set :application, "dla_manuscripts"
  set :repository, "git://github.com/mblwhoi/dla_manuscripts.git"
  set :symlink_to, "#{docroot_dir}/manuscripts"

end

