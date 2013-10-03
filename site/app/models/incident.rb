class Incident < ActiveRecord::Base
	def self.current
		where("weather IS NOT NULL")
	end
	def hash
		data = JSON.parse(blob)
		data['weather'] = JSON.parse(weather)
		Rails.logger.debug data
		data
	end
end
