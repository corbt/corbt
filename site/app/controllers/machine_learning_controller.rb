class MachineLearningController < ApplicationController
	def aggregate_data
		# @data = Incident.current.where(region: params[:region])
		# render json: @data.map{|incident| incident.hash}
		cached_json = $redis.get("ml/regions/#{params[:region]}")
		render inline: cached_json
	end
end
