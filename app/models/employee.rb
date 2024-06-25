class Employee < ApplicationRecord
  has_many :absence_requests

  validates :name, presence: true
  validates :email, presence: true
end
