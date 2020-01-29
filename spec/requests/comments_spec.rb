# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:belong_user) { create(:user) }
  let(:belong_post) { create(:post) }

  describe 'guest not signed in' do
    it 'guest can not post comment' do
      post post_comments_path(belong_post), params: { content: 'a' }
      expect(response).to redirect_to new_user_session_url
    end

    it 'guest can not delete comment' do
      comment = belong_post.comments.create(user_id: belong_user.id, content: 'a')
      comment_before = comment
      delete post_comment_path(belong_post, comment)
      expect(response).to redirect_to new_user_session_url
      expect(comment.reload).to eq comment_before
    end

    describe 'user signed in' do
      before { belong_user.confirm }
      before { sign_in belong_user }

      it 'user can delete own comment' do
        comment = belong_post.comments.create(user_id: belong_user.id, content: 'a')
        delete post_comment_path(belong_post, comment)
        expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
      end

      it 'user can not delete others comment' do
        other_user = create(:user)
        other_user.confirm
        comment = belong_post.comments.create(user_id: other_user.id, content: 'a')
        expect { delete post_comment_path(belong_post, comment) }.to raise_error NoMethodError
      end
    end
  end
end
