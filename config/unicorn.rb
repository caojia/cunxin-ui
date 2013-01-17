env = ENV["RAILS_ENV"]
app_path = "/u/apps/cunxin-ui/current"
shared_path = "/u/apps/cunxin-ui/shared"
unicorn_pid = "#{app_path}/tmp/pids/unicorn.pid"

user 'deploy'
working_directory app_path
pid unicorn_pid
stderr_path "#{shared_path}/log/unicorn.log"
stdout_path "#{shared_path}/log/unicorn.log"

listen 2012
worker_processes 3
timeout 60
preload_app true

before_exec do |server|
    ENV["BUNDLE_GEMFILE"] = "#{app_path}/Gemfile"
end
