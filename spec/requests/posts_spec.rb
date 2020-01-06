# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }
  let!(:post_params) { attributes_for(:post) }
  let!(:invalid_post_params) { attributes_for(:post, title: '') }

  before { user.confirm }
  before { other_user.confirm }
  before { user.posts.create(title: 'a', content: 'a') }

  describe 'ゲストの時' do
    context 'GET #new' do
      subject { get new_post_path }
      it 'signinページにリダイレクトされること' do
        is_expected.to redirect_to new_user_session_url
      end
    end
    context 'POST #create' do
      it 'signinページにリダイレクトされること' do
        post posts_path, params: { post: post_params }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'GET #edit' do
      subject { get edit_post_path(1) }
      it 'signinページにリダイレクトされること' do
        is_expected.to redirect_to new_user_session_url
      end
    end
    context 'PATCH #update' do
      it 'signinページにリダイレクトされること' do
        patch post_path(1), params: { post: post_params }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'DELETE #destroy' do
      it 'signinページにリダイレクトされること' do
        delete post_path(1), params: { post: post_params }
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  describe 'ログインしている時' do
    before do
      sign_in user
    end

    describe 'GET #new' do
      subject { get new_post_path }
      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end

    describe 'POST #create' do
      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          post posts_path, params: { post: post_params }
          expect(response.status).to eq 302
        end

        it 'createが成功すること' do
          expect do
            post posts_path, params: { post: post_params }
          end.to change(Post, :count).by 1
        end
      end

      context 'パラメータが不正な場合' do
        it 'リクエストが成功すること' do
          post posts_path, params: { post: invalid_post_params }
          expect(response.status).to eq 200
        end

        it 'createが失敗すること' do
          expect do
            post posts_path, params: { post: invalid_post_params }
          end.to change(Post, :count).by 0
        end
      end
    end

    describe 'GET #edit' do
      subject { get edit_post_path(1) }
      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end

    describe 'PATCH #update' do
      context 'パラメータが妥当な場合' do
        it 'updateが成功すること' do
          patch post_path(1), params: { post: { title: 'not_blank', content: 'Updated!' } }
          get post_path(1)
          expect(response.body).to include 'Updated!'
        end

        context 'パラメータが不正な場合' do
          it 'updateが失敗すること' do
            patch post_path(1), params: { post: { title: '', content: 'Updated!' } }
            get post_path(1)
            expect(response.body).to_not include 'Updated!'
          end
        end
      end

      describe 'DELETE #destroy' do
        subject { delete post_path(1) }
        it 'deleteが成功すること' do
          expect { subject }.to change { Post.count }.by(-1)
        end
      end
    end
  end

  describe '別のユーザーからの操作' do
    before do
      sign_in other_user
    end

    describe 'GET #edit' do
      subject { get edit_post_path(1) }
      it 'リダイレクトされること' do
        is_expected.to redirect_to root_url
      end
    end

    describe 'PATCH #update' do
      context 'パラメータが妥当な場合' do
        it 'リダイレクトされること' do
          patch post_path(1), params: { post: { title: 'not_blank', content: 'Updated!' } }
          expect(response).to redirect_to root_url
        end

        context 'パラメータが不正な場合' do
          it 'リダイレクトされること' do
            patch post_path(1), params: { post: { title: '', content: 'Updated!' } }
            expect(response).to redirect_to root_url
          end
        end
      end

      describe 'DELETE #destroy' do
        subject { delete post_path(1) }
        it 'リダイレクトされること' do
          is_expected.to redirect_to root_url
        end
      end
    end
  end
end
