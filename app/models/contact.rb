class Contact < ApplicationRecord
  # Add a search scope to handle query filtering
  scope :search, ->(query) {
    where("name ILIKE ? OR phone ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  }
end
