class DonCorbittController < ApplicationController
	def show

	end
	def get_threads_by_list 
		render json: UsenetList.find(params[:list_id]).usenet_threads
	end
	def get_posts_by_thread 
		render json: UsenetThread.find(params[:thread_id]).usenet_posts
	end
end
