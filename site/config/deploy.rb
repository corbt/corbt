require '../conf'
require 'capistrano/ext/multistage'
require 'capistrano-unicorn'
require 'bundler/capistrano'
require 'whenever/capistrano'
require 'cape'

set :whenever_roles, [:app]
set :whenever_command, 'bundle exec whenever'

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

set :unicorn_pid, "#{Site::CONFIG[:app_dir]}/site/shared/pids/unicorn.pid"

namespace :deploy do
  namespace :assets do
    task :precompile, :except => { :no_release => true } do
      run <<-CMD.compact
        cd -- #{latest_release.shellescape} &&
        #{rake} RAILS_ENV=#{rails_env.to_s.shellescape} assets:precompile
      CMD
    end
  end
end

Cape do
	mirror_rake_tasks :blog
end

after 'deploy:restart', 'deploy:assets:precompile', 'deploy:migrate', 'whenever:update_crontab'
after 'deploy:restart', 'unicorn:stop', 'unicorn:start'
