class Organization < ApplicationRecord
  enum type: [:interest_group, :political]
  has_many :organization_email_mapping
  validates :name, presence: true, allow_blank: false
end
