class ForumThreadsController < ApplicationController

	before_action :authenticate_user!, only: [:new,:create]
	before_action :set_forum_thread, only: [:show, :like_thread, :dislike_thread]

	def index
		@thread = ForumThread.order(id: :desc)
	end

	def show
		@thread = ForumThread.find(params[:id])
		@post = ForumPost.new
	end

	def new
		@thread = ForumThread.new
	end

	def create
		@thread = ForumThread.new(resource_params)
		@thread.user = current_user

		if @thread.save
		redirect_to root_path
		else
			render 'new'
		end

	end

	def like_thread
		liked_thread = @thread.likes.find_or_create_by(user: current_user)
		liked_thread.update(like: true)
		redirect_to root_path(@thread)
	end

	def dislike_thread
		disliked_thread = @thread.likes.find_or_create_by(user: current_user)
		disliked_thread.update(like: false)
		redirect_to root_path(@thread)
	end

	private

	def resource_params
		params.require(:forum_thread).permit(:title, :content)
	end

	def set_forum_thread
		@thread = ForumThread.find(params[:id])
	end
end