# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    it 'should be valid' do
      comment = build(:comment)
      expect(comment.valid?).to eq true
    end

    it 'content should be present' do
      comment = build(:comment, content: '')
      expect(comment.valid?).to eq false
    end
  end

  describe 'association' do
    it 'should depend on user' do
      belong_user = create(:user)
      belong_post = create(:post)
      comment = belong_user.comments.create(content: 'a', post_id: belong_post.id)
      belong_user.destroy
      expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'should depend on post' do
      belong_user = create(:user)
      belong_post = create(:post)
      comment = belong_post.comments.create(content: 'a', user_id: belong_user.id)
      belong_post.destroy
      expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
