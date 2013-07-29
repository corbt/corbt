require '../conf'
Dir["./packages/*.rb"].each {|file| require file }


policy :stack, :roles => :app do 
  requires :git
  requires :vim
  requires :ruby
end

deployment do
  delivery :capistrano do 
    role :app, Site::CONFIG[:server]
    set :user, "deploy"
    logger.level = Capistrano::Logger::TRACE
    default_run_options[:shell] = '/bin/bash'
  end
end