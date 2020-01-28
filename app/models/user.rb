# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin_flg              :boolean
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  github                 :string(255)
#  name                   :string(255)      default(""), not null
#  profile                :text(65535)
#  provider               :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  twitter                :string(255)
#  uid                    :string(255)
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy

  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: %i[github]
  validates :name, presence: true, length: { maximum: 50 }
  validates :profile, length: { maximum: 400 }
  validates :github, length: { maximum: 255 }
  validates :twitter, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_github_oauth(auth, _signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    user ||= User.new(provider: auth.provider,
                      uid: auth.uid,
                      name: auth.info.name,
                      email: auth.info.email,
                      password: Devise.friendly_token[0, 20])
    user.skip_confirmation!
    user.save
		##初期パスワードの通知メール　セキュリティ面を考えて除外
    # if user.password
      # NotificationMailer.send_password_for_github_registration(user).deliver
    # end
    user
  end
end
