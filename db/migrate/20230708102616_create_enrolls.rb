class CreateEnrolls < ActiveRecord::Migration[7.0]
  def change
    create_table :enrolls do |t|
      t.string :status
      t.references :program, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
