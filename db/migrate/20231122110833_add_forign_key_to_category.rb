class AddForignKeyToCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :category, null: true
  end
end
