Capistrano::Configuration.instance.load do

  set :application, "dla_oral_histories"
  set :repository, "git://github.com/mblwhoi/dla_oral_histories.git"
  set :symlink_to, "#{docroot_dir}/oral_histories"

end

