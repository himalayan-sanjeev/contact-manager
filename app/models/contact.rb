class Contact < ApplicationRecord
  # Regular expression for email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # Validating attributes for data integrity
  validates :name, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true
  validates :phone, presence: true, length: { is: 10 }, numericality: { only_integer: true }

  # Add a search scope to handle query filtering
  scope :search, ->(query) {
    where("name ILIKE ? OR phone ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  }
end
