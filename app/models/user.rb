class User < ApplicationRecord
  has_many :ratings # Người dùng có nhiều đánh giá
  has_many :borrowings # Người dùng có nhiều phiếu mượn

  # Validate
  validates :name, presence: true
  validates :user_name, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true
end
