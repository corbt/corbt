require '../conf'
require 'capistrano/ext/multistage'
require 'capistrano-unicorn'

set :application, "corbt"
set :repository,  Site::CONFIG[:repository]
set :scm,					:git

set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true 
set :deploy_via, :remote_cache

set :user,				"deploy"

set :stages,			 ["production"]
set :default_stage, "production"

set :use_sudo, false

# role :web, 				Site::CONFIG[:server]
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

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