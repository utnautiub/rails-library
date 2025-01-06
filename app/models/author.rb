class Author < ApplicationRecord
  has_many :books # 1 Tác giả có nhiều sách

  # Validate
  validates :name, presence: true
end
