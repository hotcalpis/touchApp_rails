# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'post created!'
      redirect_to @post
    else
      render new_post_path
    end
  end

  def index
    @posts = Post.page(params[:page]).per(8)
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = 'post updated!'
      redirect_to @post
    else
      flash[:danger] = 'The form contains error.'
      # 本当はrenderにして編集内容を残しておきたいけど"Missing template posts/4/edit"というエラーが発生
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'post deleted!'
    redirect_to user_url current_user
  end

  private

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
