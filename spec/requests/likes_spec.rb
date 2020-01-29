# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let(:belong_user) { create(:user) }
  let(:belong_post) { create(:post) }

  context 'guest not signed in' do
    it 'likes#create should redirect to sign_in page' do
      post post_likes_path(belong_post)
      expect(response).to redirect_to new_user_session_url
    end
  end

  context 'user signed in' do
    it 'likes#create should work one time only before likes#destroy' do
      belong_user.confirm
      sign_in belong_user

      expect(belong_post.likes_count).to eq 0

      post post_likes_path(belong_post)
      expect(belong_post.reload.likes_count).to eq 1

      post post_likes_path(belong_post)
      expect(belong_post.reload.likes_count).to eq 1

      like_id = Like.find_by(user_id: belong_user, post_id: belong_post).id

      delete post_like_path(post_id: belong_post.id, id: like_id)
      expect(belong_post.reload.likes_count).to eq 0

      expect { delete post_like_path(post_id: belong_post.id, id: like_id) }.to raise_error NoMethodError

      post post_likes_path(belong_post)
      expect(belong_post.reload.likes_count).to eq 1
    end
  end
end
