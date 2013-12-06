require 'rubygems'
require 'optparse'
require 'yaml'

namespace :blog do 
	desc 'Run Jekyll in config/jekyll directory without having to cd there'
	task :g do
	  Dir.chdir("config/jekyll") do
	    system('bundle exec jekyll build')
	  end
	end
	desc 'Run Jekyll in config/jekyll directory with --watch'
	task :ag do
	  Dir.chdir("config/jekyll") do
	    system('bundle exec jekyll build --watch')
	  end
	end

	desc "create new post"
	task :np do
	  OptionParser.new.parse!
	  ARGV.shift
	  title = ARGV.join(' ')

	  path = "config/jekyll/_posts/#{Date.today}-#{title.downcase.gsub(/[^[:alnum:]]+/, '-')}.markdown"
	  
	  if File.exist?(path)
	    puts "[WARN] File exists - skipping create"
	  else
	    File.open(path, "w") do |file|
	      file.puts YAML.dump({'layout' => 'post', 'published' => false, 'title' => title})
	      file.puts "---"
	    end
	  end

	  exit 1
	end
end