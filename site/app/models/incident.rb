class Incident < ActiveRecord::Base
	def self.current
		where("weather IS NOT NULL").where("traffic IS NOT NULL")
	end
	def hash
		data = JSON.parse(blob)
		data['weather'] = JSON.parse(weather)
		data['traffic']	= JSON.parse(traffic) if not traffic.nil?
		data
	end
	def self.region_to_json region
		incidents = current.where(region: region)
		return incidents.map{|incident| incident.hash}.to_json
	end
end