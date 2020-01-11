# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    redirect_to(root_url) && return unless @user.confirmed?
    @posts = @user.posts.page(params[:page]).per(8)
    @like_posts = @user.liked_posts.page(params[:page]).per(8)
  end
end
