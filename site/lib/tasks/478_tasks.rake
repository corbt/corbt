require 'net/http'

namespace :cs478 do 
	desc "Poll the Bing incidents API"
	task :slurp_bing => :environment do
		key = "AvwV4cUSi6kmQlDSmC7u3UEh_h3HqUaw81GSZ6nN7hkCPegKT6Rd-a602xJ3NSAP"
		coord1 = "50.26,-2.77" # Southern England
		coord2 = "53.6,1.9"

		# url = URI.parse("http://dev.virtualearth.net/REST/v1/Traffic/Incidents/47.7,-112.3,40.9,-111.4?key=AvwV4cUSi6kmQlDSmC7u3UEh_h3HqUaw81GSZ6nN7hkCPegKT6Rd-a602xJ3NSAP")
		url = URI.parse("http://dev.virtualearth.net/REST/v1/Traffic/Incidents/#{coord1},#{coord2}?t=1&key=#{key}")
		req = Net::HTTP::Get.new(url.to_s)
		data = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
		json = JSON.parse(data.body)
		puts Time.now
		json['resourceSets'][0]['resources'].each do |incident|
			id = incident['incidentId']
			if Incident.find_by_incidentId(id).nil?
				Incident.create(blob: incident.to_s, incidentId: id)
				puts "persisted incident #{id}"
			else
				puts "duplicate incident #{id} discarded"
			end
		end
		puts "done"
	end
end
