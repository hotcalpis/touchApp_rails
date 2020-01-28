# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  context 'guest not signed in' do
    it 'likes#create should redirect to sign_in page' do
      post = create(:post)
      post post_likes_path(post)
      expect(response).to redirect_to new_user_session_url
    end
  end

  context 'user signed in' do
    it 'likes#create should work one time only before likes#destroy' do
      user = create(:user)
      user.confirm
      sign_in user
      post = create(:post)

      expect(post.likes_count).to eq 0

      post post_likes_path(post)
      expect(post.reload.likes_count).to eq 1

      post post_likes_path(post)
      expect(post.reload.likes_count).to eq 1

      like_id = Like.find_by(user_id: user, post_id: post).id

      delete post_like_path(post_id: post.id, id: like_id)
      expect(post.reload.likes_count).to eq 0

      expect { delete post_like_path(post_id: post.id, id: like_id) }.to raise_error NoMethodError

      post post_likes_path(post)
      expect(post.reload.likes_count).to eq 1
    end
  end
end
