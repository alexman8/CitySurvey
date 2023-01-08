class CreateFormFields < ActiveRecord::Migration[6.0]
  def change
    create_table :form_fields do |t|
      t.references :form, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.string :name, null: false, limit: 50
      t.integer :type, null: false, default: 0
      t.string :description, limit: 100
      t.boolean :required, null: false, default: 0

      t.index [:form_id, :name], unique: true

      t.timestamps
    end
  end
end
