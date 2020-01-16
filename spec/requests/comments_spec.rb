# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'guest not signed in' do
    it 'guest can not comment' do
      post = create(:post)
      post post_comments_path(post), params: { content: 'a' }
      expect(response).to redirect_to new_user_session_url
    end

    it 'guest can not delete comment' do
      user = create(:user)
      post = create(:post)
      comment = post.comments.create(user_id: user.id, content: 'a')
      comment_before = comment
      delete post_comment_path(post, comment)
      expect(response).to redirect_to new_user_session_url
      expect(comment.reload).to eq comment_before
    end

    describe 'user signed in' do
      it 'user can delete own comment' do
        user = create(:user)
        user.confirm
        sign_in user
        post = create(:post)
        comment = post.comments.create(user_id: user.id, content: 'a')
        delete post_comment_path(post, comment)
        expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
      end

      it 'user can not delete others comment' do
        user = create(:user)
        other_user = create(:user)
        user.confirm
        other_user.confirm
        sign_in user
        post = create(:post)
        comment = post.comments.create(user_id: other_user.id, content: 'a')
        expect { delete post_comment_path(post, comment) }.to raise_error NoMethodError
      end
    end
  end
end
