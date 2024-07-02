class AddLeaderToEmployees < ActiveRecord::Migration[7.1]
  def change
    add_column :employees, :leader_id, :integer
  end
end
