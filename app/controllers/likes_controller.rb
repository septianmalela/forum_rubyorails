class LikesController < ApplicationController

    before_action :authenticate_user!, only: [:index]
    skip_before_action :verify_authenticity_token

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
  end