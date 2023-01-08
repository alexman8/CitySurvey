# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_30_215919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "form_entries", force: :cascade do |t|
    t.bigint "form_submission_id", null: false
    t.bigint "form_field_id", null: false
    t.string "value", limit: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_field_id"], name: "index_form_entries_on_form_field_id"
    t.index ["form_submission_id", "form_field_id"], name: "index_form_entries_on_form_submission_id_and_form_field_id", unique: true
    t.index ["form_submission_id"], name: "index_form_entries_on_form_submission_id"
  end

  create_table "form_field_options", force: :cascade do |t|
    t.bigint "form_field_id", null: false
    t.string "value", limit: 50, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_field_id", "value"], name: "index_form_field_options_on_form_field_id_and_value", unique: true
    t.index ["form_field_id"], name: "index_form_field_options_on_form_field_id"
  end

  create_table "form_fields", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.string "name", limit: 50, null: false
    t.integer "type", default: 0, null: false
    t.string "description", limit: 100
    t.boolean "required", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_id", "name"], name: "index_form_fields_on_form_id_and_name", unique: true
    t.index ["form_id"], name: "index_form_fields_on_form_id"
  end

  create_table "form_submissions", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_id"], name: "index_form_submissions_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.string "description", limit: 100
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token", limit: 25, null: false
  end

  add_foreign_key "form_entries", "form_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "form_entries", "form_submissions", on_update: :cascade, on_delete: :cascade
  add_foreign_key "form_field_options", "form_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "form_fields", "forms", on_update: :cascade, on_delete: :cascade
  add_foreign_key "form_submissions", "forms", on_update: :cascade, on_delete: :cascade
end
