# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20201016175418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "icon_index", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "subcategory_id"
    t.bigint "executor_id"
    t.string "city", null: false
    t.string "description", default: ""
    t.decimal "price", precision: 10, scale: 2, default: "0.0"
    t.date "date"
    t.string "picture", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["executor_id"], name: "index_orders_on_executor_id"
    t.index ["subcategory_id"], name: "index_orders_on_subcategory_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.bigint "category_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "superusers", force: :cascade do |t|
    t.string "login", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.float "rank", default: 0.0
    t.string "avatar"
    t.string "phone_number", null: false
    t.string "password_digest", null: false
    t.string "description", default: ""
    t.bigint "subcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subcategory_id"], name: "index_users_on_subcategory_id"
  end

  add_foreign_key "orders", "users", column: "executor_id"
end
