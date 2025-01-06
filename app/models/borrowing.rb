class Borrowing < ApplicationRecord
  belongs_to :user # Phiếu mượn chỉ thuộc về 1 người dùng
  has_many :borrowing_items # Phiếu mượn có nhiều vật phẩm

  # Validate
  validates :start_at, presence: true
  validates :end_at, presence: true
end
