class LikesController < ApplicationController

  def create
    unless current_user.likes.find_by(post_id: params[:post_id])
      @like = current_user.likes.create(post_id: params[:post_id])
      @post = Post.find(params[:post_id])
      @likes = @post.likes
    end
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy
    @post = Post.find(params[:post_id])
    @likes = @post.likes
  end

end
