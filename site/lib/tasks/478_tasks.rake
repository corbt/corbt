require 'net/http'

Region = Struct.new :coord1, :coord2, :name

regions = [
	Region.new("50.26,-2.77","53.6,1.9","london"),
	Region.new("56.52,18.7","60,20.3","stockholm"),
	Region.new("40.52,-0.239","42.146,3.5","barcelona"),
	Region.new("39.95,-112.37","40.93,-111.48","slc"),
	Region.new("47.15,-122.58","48.013,-121.843","seattle"),
	Region.new("37.0,-122.8","38,-121.64","sf"),
	Region.new("33.8,-118.36","34.2,-117.6","la"),
	Region.new("40.59,-74.2","41.1,-73.39","nyc"),
	Region.new("52.33,13.5","52.71,13.71","berlin"),
	Region.new("48.55,1.97","49.1,2.76","paris"),
	Region.new("-33.94,-71.31","-33.04,-69.89","santiago"),
	Region.new("35.22,140.41","36.41,140.74","tokyo"),
]

namespace :cs478 do 
	desc "Poll the Bing incidents API"
	task :slurp_bing => :environment do
		key = "AvwV4cUSi6kmQlDSmC7u3UEh_h3HqUaw81GSZ6nN7hkCPegKT6Rd-a602xJ3NSAP"
		puts Time.now
		regions.each do |region|
			puts "\tProcessing region #{region.name}"

			url = URI.parse("http://dev.virtualearth.net/REST/v1/Traffic/Incidents/#{region.coord1},#{region.coord2}?t=1&key=#{key}")
			req = Net::HTTP::Get.new(url.to_s)
			data = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
			json = JSON.parse(data.body)
			json['resourceSets'][0]['resources'].each do |incident|
				id = incident['incidentId']
				if Incident.find_by_incidentId(id).nil?
					Incident.create(blob: incident.to_s, incidentId: id, region: region.name)
					puts "\t\tpersisted incident #{id}"
				else
					puts "\t\tduplicate incident #{id} discarded"
				end
			end
		end
	end
end
