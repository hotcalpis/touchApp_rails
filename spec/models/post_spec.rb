require 'rails_helper'

RSpec.describe Post, type: :model do
  
  describe 'validation' do
    it 'is valid with title and content' do
      post = build(:post)
      expect(post).to be_valid
    end

    it 'is invalid without title' do
      post = build(:post, title: "")
      expect(post).to be_invalid
    end

    it 'is invalid without content' do
      post = build(:post, content: "")
      expect(post).to be_invalid
    end

    it 'is invalid without user' do
      post = build(:post, user: nil)
      expect(post).to be_invalid
    end

    # 50文字以下でfailure
    it 'is invalid with too long title' do
      post = build(:post, title: "a" * 51)
      expect(post).to be_invalid
    end

    # 2000文字以下でfailure
    it 'is invalid with too long content' do
      post = build(:post, content: "a" * 2001)
      expect(post).to be_invalid
    end

    it 'order should be most recent first' do
      first_created = create(:post)
      second_created = create(:post)
      expect(second_created).to eq Post.first
    end

    it 'should depend on user' do
      belong_user = create(:user)
      post = belong_user.posts.create(title: "Lorem", content: "ipsum")
      belong_user.destroy
      expect{ post.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
