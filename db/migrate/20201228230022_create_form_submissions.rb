class CreateFormSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :form_submissions do |t|
      t.references :form, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }

      t.timestamps
    end
  end
end
