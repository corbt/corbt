require 'json'

namespace :dc do
	desc "Import/collate Don Corbitt data"
	task :import => :environment do
		UsenetList.destroy_all
		UsenetThread.destroy_all
		UsenetPost.destroy_all

		file = File.open('/home/kyle/proj/DonCorbittProject/usenet/json/data.json')
		file.each_line do |thread|
			begin
				thread = JSON.parse(thread)
			rescue
				"Bad thread: #{thread["list"]}/#{thread["id"]}"
				break
			end
			list = UsenetList.find_or_create_by_name(thread["list"])
			list.increment(:num_threads).save
			thread["usenet_list"] = list
			posts = thread["posts"]
			thread.except!("list", "posts")

			t = UsenetThread.create(thread)
			posts.each{ |p| UsenetPost.create(p.merge({usenet_thread: t})) }
		end
	end
end