require 'rails_helper'

RSpec.describe "Likes", type: :request do
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
    delete post_like_path(post_id: post.id, id: 1 )
    expect(post.reload.likes_count).to eq 0
    post post_likes_path(post)
    expect(post.reload.likes_count).to eq 1
  end
end