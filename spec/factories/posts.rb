# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  comments_count :integer          default(0)
#  content        :text(65535)      not null
#  likes_count    :integer          default(0)
#  title          :text(65535)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_posts_on_likes_count_and_created_at  (likes_count,created_at)
#  index_posts_on_user_id                     (user_id)
#  index_posts_on_user_id_and_created_at      (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :post do
    sequence(:id) { |i| i }
    title { 'TestTitle' }
    content { 'TestContent' }
    association :user

    trait :have_likes do
      after(:create) { |post| create_list(:like, 5, post: post) }
    end
  end
end
