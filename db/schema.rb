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

ActiveRecord::Schema[8.0].define(version: 2025_01_02_055317) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name", null: false
    t.string "admin_name", null: false
    t.string "password", limit: 500, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "delete_flag", default: false, null: false
  end

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "delete_flag", default: false, null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.string "image", limit: 500
    t.string "subtitle", limit: 500
    t.bigint "author_id"
    t.bigint "genre_id"
    t.integer "publishing_year"
    t.integer "quantity_in_stock", null: false
    t.string "description", limit: 1000
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "delete_flag", default: false, null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["genre_id"], name: "index_books_on_genre_id"
  end

  create_table "borrowing_items", force: :cascade do |t|
    t.bigint "borrowing_id", null: false
    t.bigint "book_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "delete_flag", default: false, null: false
    t.index ["book_id"], name: "index_borrowing_items_on_book_id"
    t.index ["borrowing_id"], name: "index_borrowing_items_on_borrowing_id"
  end

  create_table "borrowings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "start_at", null: false
    t.date "end_at", null: false
    t.date "actual_end_at"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "delete_flag", default: false, null: false
    t.index ["user_id"], name: "index_borrowings_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "delete_flag", default: false, null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "user_id", null: false
    t.integer "star", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "delete_flag", default: false, null: false
    t.index ["book_id"], name: "index_ratings_on_book_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "user_name", null: false
    t.string "password", limit: 500, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "delete_flag", default: false, null: false
  end

  add_foreign_key "books", "authors"
  add_foreign_key "books", "genres"
  add_foreign_key "borrowing_items", "books"
  add_foreign_key "borrowing_items", "borrowings"
  add_foreign_key "borrowings", "users"
  add_foreign_key "ratings", "books"
  add_foreign_key "ratings", "users"
end
