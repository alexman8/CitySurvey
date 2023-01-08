class CreateFormFieldOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :form_field_options do |t|
      t.references :form_field, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.string :value, null: false, limit: 50
      t.timestamps

      t.index [:form_field_id, :value], unique: true
    end
  end
end
