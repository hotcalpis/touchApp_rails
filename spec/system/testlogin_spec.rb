# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Testlogin', type: :system do
  # # credentialsが使えないからかcircleciがfailureを出す、2020/01/29 ローカルでpassすることを確認
  # it 'users#testlogin' do
  #   visit posts_path

  #   click_on 'テストユーザーでログイン'
  #   click_on 'マイページ'
  #   click_on 'ユーザー情報編集'
  #   click_on 'アカウント削除'
  #   page.accept_confirm
  #   sleep 1
  #   expect(User.find_by(email: 'testuser@testuser.testuser')).to be_nil

  #   click_on 'テストユーザーでログイン'
  #   expect(page).to have_selector('.alert-success', text: 'テストユーザーでログインしました')
  # end
end
