class MachineLearningController < ApplicationController
	def aggregate_data
		@data = Incident.where(region: params[:region])
		render json: @data.map{|incident| JSON.parse(incident.blob)}
	end
end
