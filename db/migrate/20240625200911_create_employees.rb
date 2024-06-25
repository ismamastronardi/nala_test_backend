class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name, limit: 255, null: false
      t.string :email, limit: 255, null: false

      t.timestamps
    end
  end
end
