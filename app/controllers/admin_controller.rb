class AdminController < ApplicationController
	layout :false
	before_action :must_be_admin

	def index
		@pagy1, @thread = pagy(ForumThread.all, items: 5)
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

	def table_post
		@pagy2, @post = pagy(ForumPost.all, items: 6)
	end

	def table_user
		@pagy3, @user = pagy(User.all, items: 7)
	end

	def table_like
		@pagy4, @like = pagy(Like.all, items: 15)
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
