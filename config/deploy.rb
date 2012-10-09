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
role :db,  "ec2-50-112-16-118.us-west-2.compute.amazonaws.com", :primary => true

set :keep_releases,  3
set :deploy_via, :remote_cache
set :user, :deploy
set :branch, :develop
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

pid = "#{current_path}/tmp/pids/unicorn.pid"
namespace :deploy do

  def start_command
    "cd #{current_path}; bundle exec unicorn -c #{current_path}/config/unicorn.rb -D -E #{rails_env}"
  end 

  desc 'Restarting unicorn'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{pid}`"
    sleep 10
    run "kill -WINCH `cat #{pid}.oldbin`"
    sleep 10
    run "kill -QUIT `cat #{pid}.oldbin`"
  end 

  desc 'Start unicorn'
  task :start, :roles => :app, :except => { :no_release => true } do
    run start_command
  end 

  desc 'Stop unicorn'
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{pid}`"
  end  

  desc "Install init.d script"
  task :install_initd, :roles => :app do
    _template = File.join(File.dirname(__FILE__), "init.d.tpl")

    project    = application
    lockfile   = "/var/lock/subsys/#{application}"
    start_cmd  = "rvm_path=~/.rvm/ ~/.rvm/bin/rvm-shell '#{rvm_ruby_string}' -c '#{start_command}'"
    reload_cmd = [ 
      "kill -USR2 `cat #{pid}`",
      "sleep 10",
      "kill -WINCH `cat #{pid}.oldbin`",
      "sleep 10",
      "kill -QUIT `cat #{pid}.oldbin`"
    ].join(" && ")

    s = IO.read(_template)
    put ERB.new(s).result(binding), "#{project}.initd"
    sudo "mv -f #{project}.initd /etc/init.d/#{project}"
    sudo "chmod +x /etc/init.d/#{project}"
    sudo "/sbin/chkconfig --add #{project}"
    sudo "/sbin/chkconfig #{project} on"
  end

end

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
