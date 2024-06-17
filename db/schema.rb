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

ActiveRecord::Schema[7.1].define(version: 2024_06_15_144821) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["scam_id"], name: "index_fraud_reports_on_scam_id"
  end

  create_table "scams", force: :cascade do |t|
    t.string "name", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "fraud_reports", "scams"
end
