require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, "cunxin-ui"
set :repository,  "git@github.com:willamette/cunxin-ui.git"

set :scm, :git

set :rvm_type, :user
set :rvm_ruby_string, 'ruby-1.9.3-p0'

load "deploy/assets"

role :web, "ec2-50-112-16-118.us-west-2.compute.amazonaws.com"
role :app, "ec2-50-112-16-118.us-west-2.compute.amazonaws.com"
role :db,  "ec2-50-112-16-118.us-west-2.compute.amazonaws.com"

set :keep_releases,  3
set :deploy_via, :remote_cache
set :user, :deploy
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
