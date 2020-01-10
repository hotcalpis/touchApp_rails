# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  content     :text             not null
#  likes_count :integer          default(0)
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

class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 20_000 }

  def liked_by?(user)
    user.likes.find_by(post_id: self.id)
  end
end
