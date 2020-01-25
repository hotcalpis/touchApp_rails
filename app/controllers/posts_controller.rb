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
      redirect_to @post
    else
      render new_post_path
    end
  end

  def index
    @posts = Post.includes([:user, :taggings, user: :avatar_attachment]).page(params[:page]).per(8)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes([:user, user: :avatar_attachment])
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      flash[:danger] = 'タイトル、内容を入力してください'
      # 本当はrenderにして編集内容を残しておきたいけど"Missing template posts/4/edit"というエラーが発生
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to user_url current_user
  end

  def search
    @posts = Post.search(params[:search]).includes([:user, user: :avatar_attachment]).page(params[:page]).per(8)
  end

  def tag
    @posts = Post.all.tagged_with("#{params[:tag_name]}").includes([:user, :taggings, user: :avatar_attachment]).page(params[:page]).per(8)
  end

  private

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :content, :tag_list)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
