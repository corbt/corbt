require '../conf'
require 'io/console'

password = ""
STDIN.noecho do
  print "Deploy user password: "
  password = gets.chomp
end

package :create_user do
  runner "useradd deploy -s /bin/bash -m -d /home/deploy"
  runner "echo \"deploy:#{password}\" | chpasswd"
  runner "echo \"deploy ALL=NOPASSWD: ALL\" >> /etc/sudoers"
  runner "apt-get update"

  verify { has_user "deploy" }
end

policy :bootstrap, :roles => :app do 
  requires :create_user
end

deployment do
  delivery :capistrano do 
    role :app, Site::CONFIG[:server]
    set :user, "root"
    logger.level = Capistrano::Logger::TRACE
  end
end