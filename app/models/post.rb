# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  title      :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#


class Post < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 2000 }
  validates :user, presence: true
end
