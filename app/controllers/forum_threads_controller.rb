class ForumThreadsController < ApplicationController

	before_action :authenticate_user!, only: [:new,:create]
	# before_action :set_forum_thread, only: [:show, :like_thread, :dislike_thread]
    before_action :status_forum_thread, only: [:show, :true_thread, :false_thread]

	def index
		@pagy, @thread = pagy(ForumThread.order(id: :desc), items: 6)
		# @pagy2, @post = pagy(ForumPost.all, items: 6)
	end

	def show
		@thread = ForumThread.friendly.find(params[:id])
		if @thread.status != true
			flash[:notice] = "Anda Tidak Mengakses Halaman Ini!!!"
		    redirect_to root_path
		    return
		end
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

	def true_thread
		@threads = ForumThread.friendly.find(params[:id])
		@threads.update_attributes(:status => true)
		flash[:notice] = "Admin Accept Thread '#{@threads.title}'"

	    if @threads
	      redirect_to admin_index_path(@user)
	    else
	     redirect_to admin_index_path
	    end
	end

	def false_thread
		@threads = ForumThread.friendly.find(params[:id])
		@threads.update_attributes(:status => false)
		flash[:notice] = "Admin Decline Thread '#{@threads.title}' "

	    if @threads
	      redirect_to admin_index_path(@user)
	    else
	     redirect_to admin_index_path
	    end
	end

	private

	def resource_params
		params.require(:forum_thread).permit(:title, :content)
	end

	def status_forum_thread
		@thread = ForumThread.friendly.find(params[:id])
	end
end