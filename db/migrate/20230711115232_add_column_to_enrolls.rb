class AddColumnToEnrolls < ActiveRecord::Migration[7.0]
  def change
    add_column :enrolls, :cust_name, :string
  end
end
