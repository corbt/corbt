require 'json'

namespace :dc do
	desc "Import/collate Don Corbitt data"
	task :import => :environment do
		puts "Clearing old posts"
		UsenetList.destroy_all
		UsenetThread.destroy_all
		UsenetPost.destroy_all

		file = File.open('/home/kyle/proj/DonCorbittProject/usenet/json/data.json')
		file.each_line.with_index do |thread, index|
			puts "Importing thread #{index}"
			begin
				thread = JSON.parse(thread)
			rescue
				"Bad thread: #{thread["list"]}/#{thread["id"]}"
				break
			end
			list = UsenetList.find_or_create_by_name(thread["list"])
			thread["usenet_list"] = list
			posts = thread["posts"]
			thread.except!("list", "posts")
			thread["title"] = "[No title]" if thread["title"] == nil or thread["title"].size == 0
			t = UsenetThread.create(thread)
			posts.each{ |p| UsenetPost.create(p.merge({usenet_thread: t})) }
		end
	end
end