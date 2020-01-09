# require 'rails_helper'

# RSpec.feature "Likes", type: :feature do

#   scenario 'guest not signed in', js: true do
#     post = create(:post)
#     visit post_path(post)
#     expect { find("#like_button").click }.to change(Like, :count).by(0)
#   end

#   scenario 'user signed in', js: true do
#     post = create(:post)
#     user = create(:user).confirm
#     sign_in user
#     visit post_path(post)
#     expect { find("#like_button").click }.to change(Like, :count).by(1)
#   end
# end
