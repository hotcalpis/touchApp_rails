# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin_flg              :boolean
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           default(""), not null
#  profile                :text             default("")
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryBot.define do
  factory :user do
    name { 'test' }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { 'testuser' }

    trait :have_posts do
      after(:create) { |user| create_list(:post, 5, user: user) }
    end

    trait :have_likes do
      after(:create) { |user| create_list(:like, 5, user: user) }
    end

    trait :have_comments do
      after(:create) { |user| create_list(:comment, 5, user: user) }
    end
  end

  factory :other_user, class: User do
    name { 'other_user' }
    email { 'other@user.com' }
    password { 'otheruser' }
  end
end
