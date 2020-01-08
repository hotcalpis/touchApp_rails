class LikesController < ApplicationController

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    @post = Post.find(params[:post_id])
    @likes = @post.likes
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy
    @post = Post.find(params[:post_id])
    @likes = @post.likes
  end
end
