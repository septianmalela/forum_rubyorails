class AdminController < ApplicationController
	layout :false
	before_action :must_be_admin

	def index
		@thread = ForumThread.all
	end

	def edit
		@threads = ForumThread.friendly.find(params[:id])
	end

	def update
	@threads = ForumThread.friendly.find(params[:id])
    @threads.update(resource_params)

    redirect_to admin_path
	end

	def show
		redirect_to action: 'index'
	end

	def table_post
		@post = ForumPost.all
		# @pagy2, @post = pagy(ForumPost.all, items: 6)
	end

	def table_user
		@user = User.all
	end

	def table_like
		@like = Like.all
	end

	private

	def resource_params
		params.require(:forum_thread).permit(:status)
	end

	def must_be_admin
    unless current_user && current_user.role == 'admin'
      redirect_to root_path flash[:notice] = "Anda tidak dapat mengakses halaman tersebut!!"
    end
  end
end
