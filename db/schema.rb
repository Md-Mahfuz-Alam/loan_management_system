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

ActiveRecord::Schema[7.1].define(version: 2024_07_19_180653) do
  create_table "loans", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "principle_amount", precision: 10
    t.decimal "amount_with_interest", precision: 10
    t.decimal "interest_rate", precision: 10
    t.bigint "user_id", null: false
    t.bigint "approved_by_id"
    t.bigint "rejected_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state", default: "requested", null: false
    t.index ["approved_by_id"], name: "index_loans_on_approved_by_id"
    t.index ["rejected_by_id"], name: "index_loans_on_rejected_by_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "balance", precision: 10, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "loans", "users"
  add_foreign_key "loans", "users", column: "approved_by_id"
  add_foreign_key "loans", "users", column: "rejected_by_id"
  add_foreign_key "wallets", "users"
end
