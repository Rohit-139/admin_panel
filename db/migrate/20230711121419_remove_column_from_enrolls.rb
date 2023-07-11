class RemoveColumnFromEnrolls < ActiveRecord::Migration[7.0]
  def change
    remove_column :enrolls, :cust_name, :string
  end
end
