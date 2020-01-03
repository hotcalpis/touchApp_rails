class UsersController < ApplicationController

  def tmp_post_index
    render 'layouts/tmp_post_index'
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.confirmed?
  end

end
