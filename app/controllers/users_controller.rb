class UsersController < ApplicationController
	before_action :authenticate_user!

	def edit
		@user = User.friendly.find(params[:id])
	end

	def update
		@user = User.friendly.find(params[:id])
	    @user.update(resource_params)
	    flash[:notice] = "Update Succes"

	    redirect_to users_path
	end

	private

	def resource_params
		params.require(:user).permit(:name, :avatar)
	end

end	