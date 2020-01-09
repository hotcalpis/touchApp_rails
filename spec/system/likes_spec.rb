# require 'rails_helper'

# RSpec.describe 'Likes', type: :system do
#   describe 'guest not signed in' do
#     it 'can not change like-unlike', js: true do
#       post = create(:post)
#       visit post_path(post)
#       expect { find('#like_image').click }.to change(Like, :count).by(0)
#     end
#   end

#   describe 'user signed in' do
#     it 'can change like-unlike', js: true do
#       post = create(:post)
#       user = create(:user)
#       user.confirm
#       sign_in user
#       visit post_path(post)
      
#       expect(post.likes_count).to eq 0
#       find('.like_button').click
#       wait_for_ajax(5)
#       expect(post.likes_count).to eq 1
#       find('.unlike_button').click
#       wait_for_ajax(5)
#       expect(post.likes_count).to eq 0
#       # expect{ find('#like_button').click }.to change(post.likes_count, :count).by 1
#     end
#   end
# end