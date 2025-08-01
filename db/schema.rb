# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_10_141448) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "name" ], name: "index_categories_on_name", unique: true
  end

  create_table "expenses", force: :cascade do |t|
    t.date "date"
    t.text "description"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "expenses_import_id"
    t.bigint "category_id"
    t.bigint "subcategory_id"
    t.index [ "category_id" ], name: "index_expenses_on_category_id"
    t.index [ "date", "description", "amount" ], name: "expenses_unique_index", unique: true
    t.index [ "expenses_import_id" ], name: "index_expenses_on_expenses_import_id"
    t.index [ "subcategory_id" ], name: "index_expenses_on_subcategory_id"
  end

  create_table "expenses_imports", force: :cascade do |t|
    t.string "state", default: "pending", null: false
    t.string "file_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index [ "category_id" ], name: "index_subcategories_on_category_id"
  end

  add_foreign_key "expenses", "expenses_imports"
  add_foreign_key "expenses", "subcategories"
  add_foreign_key "subcategories", "categories"
end
