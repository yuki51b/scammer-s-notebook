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

ActiveRecord::Schema[7.0].define(version: 2024_07_19_041815) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "fraud_reports", force: :cascade do |t|
    t.string "contact_method", null: false
    t.string "contact_content", null: false
    t.string "information", null: false
    t.string "urgent_action", null: false
    t.string "payment_method", null: false
    t.string "company_info", null: false
    t.text "additional_details"
    t.string "respond"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "scam_id"
    t.string "who_person", default: "怪しい人", null: false
    t.index ["scam_id"], name: "index_fraud_reports_on_scam_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "scam_id"
    t.text "users_scam_name", null: false
    t.index ["scam_id"], name: "index_posts_on_scam_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "scams", force: :cascade do |t|
    t.string "name", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "point_1"
    t.string "point_2"
    t.string "point_3"
    t.text "scam_strategy", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "avatar"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "fraud_reports", "scams"
  add_foreign_key "posts", "scams"
  add_foreign_key "posts", "users"
end
