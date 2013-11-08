require 'net/http'
require 'stringio'

Location = Struct.new :lat, :long, :label

locations = [
	Location.new(47.594, -122.332, "seattle_cl"),
	Location.new(47.610, -122.341, "seattle_fb"),
	Location.new(47.553, -122.118, "seattle_hm"),
	Location.new(40.257, -111.654, "provo_lv"),
	Location.new(40.245, -111.646, "provo_cp"),
	Location.new(40.272, -111.708, "provo_wm")
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
			TrafficReading.create(label: location.label, reading: data.body)
		end
		puts out.string
	end
end
