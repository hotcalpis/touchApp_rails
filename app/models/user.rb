class User < ApplicationRecord

  has_many :posts, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
	validates :name,  presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
										uniqueness: { case_sensitive: false }
end
