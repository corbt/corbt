class TrafficReading < ActiveRecord::Base
	belongs_to :weather_reading

	include Timezones

	def self.current
		where('weather_reading_id is not null')
	end

	def to_json
		data = {}
		data['time'] = created_at.in_time_zone(Timezones::lookup region)
		data['traffic'] = JSON.parse(reading)
		data['weather'] = JSON.parse(weather_reading.reading)
		data['region'] = region
		data.to_json
	end

	def human_label
		labels = {
			"seattle_cl" => "Seattle Statium",
			"seattle_fb" => "Seattle Waterfront",
			"seattle_hm" => "Seattle Bellevue",
			"provo_lv" => "Provo Lavell Edwards",
			"provo_cp" => "Provo South Campus",
			"provo_wm" => "Provo Walmart",
		}
		labels[label]
	end

	def self.save_region_to_disk label
		readings = current.where(label: label).includes(:weather_reading)

		disk_path = Rails.root.join("public","478","traffic","#{label}.json")
		File.open(disk_path, 'w') do |f|
		  f << "["
		  f << readings.shift.to_json
		  readings.each do |reading|
		  	f << ",#{reading.to_json}"
		  end
		  f << "]"
		end
	end
end
