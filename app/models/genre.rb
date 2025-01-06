class Genre < ApplicationRecord
  has_many :books # 1 Thể loại có nhiều sách

  # Validate
  validates :name, presence: true
end
