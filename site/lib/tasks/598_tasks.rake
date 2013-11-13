require 'net/http'
require 'stringio'

Location = Struct.new :lat, :long, :label, :region

locations = [
	Location.new(47.594, -122.332, "seattle_cl", "seattle"),
	Location.new(47.610, -122.341, "seattle_fb", "seattle"),
	Location.new(47.553, -122.118, "seattle_hm", "seattle"),
	Location.new(40.257, -111.654, "provo_lv", "provo"),
	Location.new(40.245, -111.646, "provo_cp", "provo"),
	Location.new(40.272, -111.708, "provo_wm", "provo"),
	Location.new(37.72362, -122.40134, "sf_bayview", "sf"),
	Location.new(37.78206, -121.97779, "sf_680", "sf"),
	Location.new(37.40205, -122.03163, "sf_southbay", "sf")
]

weather_locations = [
	Location.new(47.594, -122.332, nil, "seattle"),
	Location.new(40.257, -111.654, nil, "provo"),
	Location.new(37.72362, -122.40134, nil, "sf")
]

namespace :cs598r do
	desc "Take traffic readings"
	task :slurp_bing => :environment do
		out = StringIO.new
		out.puts Time.now
		locations.each do |location|
			out.puts "\tProcessing location #{location.label}"
			url = URI.parse("http://dev.virtualearth.net/REST/v1/Routes/FromMajorRoads?dest=#{location.lat},#{location.long}&du=Mile&key=#{ML478::BING_KEY}")
			req = Net::HTTP::Get.new(url.to_s)
			data = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
			TrafficReading.create(
				label: location.label, 
				region: location.region,
				reading: data.body, 
				weather_reading: WeatherReading.where(label: location.region).last
			)
		end
		puts out.string
	end

	task :cache_json => :environment do
		# Cache JSON after to not cause problems
		out = StringIO.new
		out.puts Time.now
		locations.each do |location|
		  out.puts "\tCaching JSON for label #{location.label}"
		  TrafficReading.save_region_to_disk location.label
		end
		puts out.string
	end

	task :slurp_wu => :environment do
		out = StringIO.new
		out.puts Time.now
		weather_locations.each do |location|
			out.puts "\tGetting weather #{location.region}"
			sleep 14.seconds # because of API throttling
			url = URI.parse("http://api.wunderground.com/api/#{ML478::WU_KEY}/conditions/astronomy/q/#{location.lat},#{location.long}.json")
			req = Net::HTTP::Get.new(url.to_s)
			data = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
			WeatherReading.create(label: location.region, reading: data.body)
		end
		puts out.string
	end
end
