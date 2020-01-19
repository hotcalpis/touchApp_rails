# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DeviseUsers', type: :request do
  let(:user) { create(:user) }
  let(:unconfirmed_user) { create :user }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: '') }
  let(:update_params) do
    attributes_for(:user, name: 'Updated',
                          email: 'Updated@test.com',
                          password: 'password',
                          password_confirmation: 'password',
                          current_password: 'testuser')
  end
  let(:invalid_update_params) do
    attributes_for(:user, name: '',
                          email: '',
                          password: 'password',
                          password_confirmation: 'password',
                          current_password: 'testuser')
  end

  before { user.confirm }

  describe 'GET #new' do
    subject { get new_user_registration_path }
    it 'リクエストが成功すること' do
      is_expected.to eq 200
    end
  end

  describe 'POST #create' do
    before do
      ActionMailer::Base.deliveries.clear
    end
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it '認証メールが送信されること' do
        post user_registration_path, params: { user: user_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'createが成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'リダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end

      it '認証メールが送信されないこと' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it 'createが失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.to_not change(User, :count)
      end

      it 'エラーが表示されること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include 'のエラーがあります。修正して再度送信して下さい。'
      end
    end
  end

  describe 'GET #show' do
    context '認証済みユーザーが存在する場合' do
      it 'リクエストが成功すること' do
        get "/users/#{user.id}"
        expect(response.status).to eq 200
        expect(response.body).to include user.name
      end
    end
    context '未認証ユーザーが存在する場合' do
      it 'リダイレクトされること' do
        get "/users/#{unconfirmed_user.id}"
        expect(response.status).to redirect_to root_url
      end
    end
    context 'ユーザーが存在しない場合' do
      it 'エラーが発生すること' do
        user_id = user.id
        user.destroy
        expect { get "/users/#{user_id}" }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'GET #edit' do
    subject { get edit_user_registration_path }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end
    context 'ゲストの場合' do
      it 'リダイレクトされること' do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    before do
      sign_in user
    end
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        patch user_registration_path, params: { user: update_params }
        expect(response.status).to eq 302
      end

      it 'updateが成功すること' do
        expect do
          patch user_registration_path, params: { user: update_params }
        end.to change { User.find(user.id).name }.from(user.name).to('Updated')
      end

      it 'リダイレクトされること' do
        patch user_registration_path, params: { user: update_params }
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        patch user_registration_path, params: { user: invalid_update_params }
        expect(response.status).to eq 200
      end

      it 'updateが失敗すること' do
        expect do
          patch user_registration_path, params: { user: invalid_update_params }
        end.to_not change(User.find(user.id), :name)
      end

      it 'エラーが表示されること' do
        patch user_registration_path, params: { user: invalid_update_params }
        expect(response.body).to include 'のエラーがあります。修正して再度送信して下さい。'
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete user_registration_path }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'deleteが成功すること' do
        expect { subject }.to change { User.count }.by(-1)
      end
    end
    context 'ゲストの場合' do
      it 'deleteが失敗すること' do
        expect { subject }.not_to change { User.count }
      end
    end
  end

  describe 'GET /admin' do
    subject { get '/admin' }
    before do
      sign_in user
    end
    context '権限がある場合' do
      before do
        user.update_columns(admin_flg: true)
      end
      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end
    context '権限がない場合' do
      it 'エラーが発生すること' do
        expect { subject }.to raise_error CanCan::AccessDenied
      end
    end
  end
end
