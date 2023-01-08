class CreateForms < ActiveRecord::Migration[6.0]
  def change
    create_table :forms do |t|
      t.string :title, null: false, limit: 50
      t.string :description, limit: 100
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
