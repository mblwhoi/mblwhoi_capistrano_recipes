Capistrano::Configuration.instance.load do

  set :application, "example_app"
  set :repository, "git://github.com/my-github-account/example_repo.git"
  set :symlink_to, "#{docroot_dir}/example"

end

