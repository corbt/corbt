module Timezones
	def self.lookup region
		{
			"slc" => "MST7MDT",
			"seattle" => "PST8PDT",
			"sf" => "PST8PDT",
			"la" => "PST8PDT",
			"nyc" => "EST5EDT",
			"provo" => "MST7MDT"
		}[region]
	end
end