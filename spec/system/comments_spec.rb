# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  it 'post comment and delete comment' do
    belong_user = create(:user)
    belong_user.confirm
    sign_in belong_user
    belong_post = create(:post)
    visit post_path(belong_post)

    fill_in 'コメント', with: 'a'
    click_on '投稿'
    expect(belong_post.comments.reload.length).to eq 1

    click_on '削除'
    page.accept_confirm
    sleep 1
    expect(belong_post.comments.reload.length).to eq 0
  end
end
