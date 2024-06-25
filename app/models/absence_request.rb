class AbsenceRequest < ApplicationRecord
  belongs_to :employee

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :request_type, presence: true
  validates :status, presence: true

  def days_requested
    (end_date - start_date).to_i
  end
end
