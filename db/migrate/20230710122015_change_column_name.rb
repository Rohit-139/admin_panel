class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :enrolls, :status, :level
  end
end
