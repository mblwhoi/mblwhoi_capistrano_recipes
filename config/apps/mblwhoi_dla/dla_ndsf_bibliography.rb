Capistrano::Configuration.instance.load do

  set :application, "dla_ndsf_bibliography"
  set :repository, "git://github.com/mblwhoi/dla_ndsf_bibliography.git"
  set :symlink_to, "#{docroot_dir}/ndsf_bibliography"

end

