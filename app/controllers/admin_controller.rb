class AdminController < ApplicationController
	layout :false

	def index
		@pagy1, @thread = pagy(ForumThread.all, items: 5)
		@pagy2, @post = pagy(ForumPost.all, items: 6)
		@pagy3, @user = pagy(User.all, items: 7)
		@pagy4, @like = pagy(Like.all, items: 15)
	end

	def edit
		@threads = ForumThread.find_by_id(params[:id])
	end

	def update
	@threads = ForumThread.find(params[:id])
    @threads.update(resource_params)

    redirect_to admin_path
	end

	def show
		redirect_to action: 'index'
	end

	private

	def resource_params
		params.require(:forum_thread).permit(:status)
	end
end
