require 'json'

namespace :dc do
	desc "Import/collate Don Corbitt data"
	task :import => :environment do
		UsenetList.destroy_all
		UsenetThread.destroy_all

		file = File.open('/home/kyle/proj/DonCorbittProject/usenet/json/data.json')
		threads = JSON.parse(file.read)
		threads.each do |thread|
			# thread["posts"] = thread["posts"].to_json
			thread["usenet_list"] = UsenetList.find_or_create_by_name(thread["list"])
			thread.except!("list")
			UsenetThread.create(thread)
		end
	end
end