# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    flash[:success] = 'コメントを投稿しました' if comment.save
    redirect_to @post
  end

  def destroy
    comment = Comment.find_by(user_id: current_user.id, post_id: params[:post_id], id: params[:id])
    comment.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
