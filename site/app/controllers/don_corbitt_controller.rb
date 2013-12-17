class DonCorbittController < ApplicationController

	def get_threads_by_list 
		render json: UsenetList.find(params[:list_id]).usenet_threads.order('date DESC')
	end
	def get_posts_by_thread 
		render json: UsenetThread.find(params[:thread_id]).usenet_posts.order('date')
	end
end
