# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  content     :text             not null
#  likes_count :integer
#  title       :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#

FactoryBot.define do
  factory :post do
    sequence(:id) { |i| i }
    title { 'TestTitle' }
    content { 'TestContent' }
    association :user
  end
end
