class ForumThreadsController < ApplicationController
	def index
		@threads = ForumThread.order(id: :desc)
	end

	def show
		@threads = ForumThread.find(params[:id])
	end

	def new
		@thread = ForumThread.new
	end

	def create
		@thread = ForumThread.new(resource_params)
		@thread.user = User.first
		@thread.save

		redirect_to root_path
	end

	private

	def resource_params
		params.require(:forum_thread).permit(:title, :content)
	end
end