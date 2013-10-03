class MachineLearningController < ApplicationController
	def aggregate_data
		@data = Incident.current.where(region: params[:region])
		render json: @data.map{|incident| incident.hash}
	end
end
