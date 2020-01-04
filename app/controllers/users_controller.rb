class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.confirmed?
  end

end
