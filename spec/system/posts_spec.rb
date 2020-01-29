# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  # # simplemdeエディタにfill_inやsetをする方法がない
  # it 'post post and delete post' do
  #   belong_user = create(:user)
  #   belong_user.confirm
  #   sign_in belong_user
  #   visit new_post_path
  #   fill_in 'タイトル', with: 'testtitle'
  #   page.all('.form-control')[2].set('testcontent')
  #   click_on '投稿'
  #   click_on '編集'
  #   click_on '削除'
  #   page.accept_confirm
  #   expect(page.all).to include '削除しました'
  # end
end
