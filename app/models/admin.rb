class Admin < ApplicationRecord
  # Validate
  validates :name, presence: true
  validates :admin_name, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true
  # validates :password_confirmation, presence: true
end
