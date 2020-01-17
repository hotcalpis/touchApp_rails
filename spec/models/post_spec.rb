# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  comments_count :integer          default(0)
#  content        :text(65535)      not null
#  likes_count    :integer          default(0)
#  title          :text(65535)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validation' do
    it 'is valid with title and content' do
      post = build(:post)
      expect(post).to be_valid
    end

    it 'is invalid without title' do
      post = build(:post, title: '')
      expect(post).to be_invalid
    end

    it 'is invalid without content' do
      post = build(:post, content: '')
      expect(post).to be_invalid
    end

    it 'is invalid without user' do
      post = build(:post, user: nil)
      expect(post).to be_invalid
    end

    # 255文字以下でfailure
    it 'is invalid with too long title' do
      post = build(:post, title: 'a' * 256)
      expect(post).to be_invalid
    end

    # 20000文字以下でfailure
    it 'is invalid with too long content' do
      post = build(:post, content: 'a' * 20_001)
      expect(post).to be_invalid
    end
  end

  describe 'default scope' do
    it 'order should be most recent first' do
      first_created = create(:post)
      sleep 1
      second_created = create(:post)
      expect(second_created).to eq Post.first
    end
  end

  describe 'association' do
    it 'should depend on user' do
      belong_user = create(:user)
      post = belong_user.posts.create(title: 'Lorem', content: 'ipsum')
      belong_user.destroy
      expect { post.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'can have many likes' do
      post = create(:post, :have_likes)
      expect(post.likes.length).to eq 5
    end

    it 'can have many comments' do
      user = create(:user, :have_comments)
      expect(user.comments.length).to eq 5
    end
  end
end
