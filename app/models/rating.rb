class Rating < ApplicationRecord
  belongs_to :book # Đánh giá thuộc về 1 sách
  belongs_to :user # Đánh giá thuộc về 1 người dùng

  #Validate
  validates :stars, presence: true
end
