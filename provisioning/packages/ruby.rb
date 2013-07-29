require '../conf'

package :install_rbenv do
  requires :git
  description 'Ruby RBEnv'

  runner  "git clone git://github.com/sstephenson/rbenv.git ~/.rbenv"
  runner "git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"

  push_text 'export PATH="$HOME/.rbenv/bin:$PATH"', "~/.bash_profile"
  push_text 'eval "$(rbenv init -)"', "~/.bash_profile"

  verify do
    has_executable "~/.rbenv/bin/rbenv"
  end
end

package :install_ruby do
  requires :install_rbenv

  version = Site::CONFIG[:ruby_version]

  runner "rbenv install #{version}", sudo: true
  runner "rbenv rehash", sudo: true

  verify do
    has_executable "~/.rbenv/shims/ruby"
  end
end

package :rbenv_bundler do
  requires :use_rbenv

  runner "gem install bundler", sudo: true
  runner "rbenv rehash", sudo: true

  verify do 
    @commands << "gem list | grep bundler"
  end
end

package :use_rbenv do
  requires :install_ruby

  version = Site::CONFIG[:ruby_version]

  runner "rbenv rehash", sudo: true
  runner "rbenv global #{version}", sudo: true
  runner "rbenv rehash", sudo: true
end

package :install_rubygems do
  requires :use_rbenv

  description 'Ruby Gems Package Management System'
  version '1.8.25'

  source "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz" do
    custom_install "ruby setup.rb", sudo: true
    
    # post :install, "ln -s /usr/bin/gem1.8 /usr/bin/gem"
    post :install, "gem update --system", sudo: true
  end

  verify do
    has_executable "~/.rbenv/shims/gem"
  end
end

package :install_bundler do
  requires :use_rbenv
  requires :install_rubygems

  runner "gem install bundler --no-rdoc --no-ri", sudo: true
  runner "rbenv rehash", sudo: true
  
  verify do
    has_executable "~/.rbenv/shims/bundle"
  end
end

package :ruby_essentials do
  apt 'libssl-dev zlib1g zlib1g-dev libreadline-dev', sudo: true
end

package :ruby_rbenv, provides: :ruby do
  requires :ruby_essentials
  requires :install_rubygems
  requires :install_bundler
end