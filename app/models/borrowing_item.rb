class BorrowingItem < ApplicationRecord
  belongs_to :borrowing # Vật phẩm thuộc về 1 phiếu mượn
  belongs_to :book # Vật phẩm thuộc về 1 sách

  # Validate
  validates :quantity, presence: true
end
