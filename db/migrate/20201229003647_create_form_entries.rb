class CreateFormEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :form_entries do |t|
      t.references :form_submission, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :form_field, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.string :value, limit: 100
      t.timestamps

      t.index [:form_submission_id, :form_field_id], unique: true
    end
  end
end
