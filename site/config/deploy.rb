require '../conf'
require 'capistrano/ext/multistage'
require 'capistrano-unicorn'
require 'bundler/capistrano'
Dir[File.join(File.dirname(__FILE__),"deploy","recipes","**","*.rb")].each{ |f| require f }


set :application, 	"corbt"
set :repository,  	Site::CONFIG[:repository]
set :scm,						:git

set :deploy_subdir, "/site"
set :strategy,      RemoteCacheSubdir.new(self)


set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true 
set :deploy_via, :remote_cache

set :user,				"deploy"

set :stages,			 ["production"]
set :default_stage, "production"

set :use_sudo, false

after 'deploy:restart', 'unicorn:restart'