server 						Site::CONFIG[:server], :app, :web, :db, primary: true
set :deploy_to,		Site::CONFIG[:app_dir]
set :branch,			"master"