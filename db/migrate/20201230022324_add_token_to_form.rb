class AddTokenToForm < ActiveRecord::Migration[6.0]
  def up
    add_column :forms, :token, :string, limit: 25, after: :status
    Form.all.each { |form| form.regenerate_token }
    change_column_null :forms, :token, false
  end

  def down
    remove_column :forms, :token
  end
end
