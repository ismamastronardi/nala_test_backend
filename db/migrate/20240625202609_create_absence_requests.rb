class CreateAbsenceRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :absence_requests do |t|
      t.references :employee, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :request_type, null: false
      t.string :reason
      t.string :status, null: false

      t.timestamps
    end
  end
end
