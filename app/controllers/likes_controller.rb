# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    unless Like.find_by(user_id: current_user.id, post_id: params[:post_id])
      current_user.likes.create(post_id: params[:post_id])
      @post = Post.find(params[:post_id])
    end
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id], id: params[:id])
    like.destroy
    @post = Post.find(params[:post_id])
  end
end
