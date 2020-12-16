class LikesController < ApplicationController

    before_action :authenticate_user!, only: [:index]
    skip_before_action :verify_authenticity_token
    before_action :set_forum_thread, only: [:like_thread, :dislike_thread]


    def index
        @user = current_user.id
        @thread = params[:forum_thread_id]
        likes = {like: true, user_id: @user, forum_thread_id: @thread}
        @like = Like.new(likes)

        if @like.save
          redirect_to root_path(@like)
        else
         redirect_to root_path
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

  def set_forum_thread
    @thread = ForumThread.find(params[:id])
  end


  end