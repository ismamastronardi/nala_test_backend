class Employee < ApplicationRecord
  belongs_to :leader, class_name: "Employee", optional: true
  has_many :subordinates, class_name: "Employee", foreign_key: "leader_id"
  has_many :absence_requests, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true

  def days_absent
    absence_requests.where.not(status: "rejected").sum(&:days_requested)
  end

  def days_requested
    absence_requests.sum(&:days_requested)
  end

end
