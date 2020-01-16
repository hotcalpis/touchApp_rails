# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    redirect_to(root_url) && return unless @user.confirmed?
    @posts = @user.posts.page(params[:page]).per(8)
    @like_posts = @user.liked_posts.page(params[:page]).per(8)
  end

  def testlogin
    user = User.find_by(email: 'testuser@testuser.testuser')
    sign_in user
    flash[:success] = 'テストユーザーでログインしました。'
    redirect_to root_url
  end
end
