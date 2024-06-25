class Employee < ApplicationRecord
  has_many :absence_requests

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true

  def days_absent
    absence_requests.where.not(status: "rejected").sum(&:days_requested)
  end

end
