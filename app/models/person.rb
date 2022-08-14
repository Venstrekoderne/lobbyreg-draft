class Person < ApplicationRecord
  has_many :email
  belongs_to :organization
  validates :name, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false
end
