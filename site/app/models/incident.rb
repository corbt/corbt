class Incident < ActiveRecord::Base
	def self.current
		where("weather IS NOT NULL").where("traffic IS NOT NULL")
	end
	def to_json
		data = JSON.parse(blob)
		data['weather'] = JSON.parse(weather)
		data['traffic']	= JSON.parse(traffic) if not traffic.nil?
		data.to_json
	end
	def self.region_to_json region
		incidents = current.where(region: region)
		return incidents.map{|incident| incident.hash}.to_json
	end
	def self.save_region_to_disk region
		incidents = current.where(region: region)

		disk_path = Rails.root.join("public","478","#{region}.json")
		File.open(disk_path, 'w') do |f|
		  f << "["
		  f << incidents.shift.to_json
		  incidents.each do |incident|
		  	f << ",#{incident.to_json}"
		  end
		  f << "]"
		end

	end
end