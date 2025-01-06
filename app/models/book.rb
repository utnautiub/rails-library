class Book < ApplicationRecord
  belongs_to :author # 1 Sách có 1 tác giả
  belongs_to :genre # 1 Sách có 1 thể loại
  has_many :ratings # 1 Sách có nhiều đánh giá xếp hạng
  has_many :borrowing_items # 1 Sách có thể mượn nhiều

  # Validate
  validates :title, presence: true
  validates :author_id, presence: true
  validates :genre_id, presence: true
  validates :quantity_in_stock, presence: true
end
