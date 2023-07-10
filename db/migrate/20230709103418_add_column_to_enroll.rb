class AddColumnToEnroll < ActiveRecord::Migration[7.0]
  def change
    add_column :enrolls, :name, :string
  end
end
