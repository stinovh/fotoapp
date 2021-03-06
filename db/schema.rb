# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160621184224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "full_name"
    t.string   "email"
    t.text     "notification_params"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "purchased_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "payment_method"
    t.string   "address"
    t.string   "bitcoin_params"
    t.integer  "confirmations"
  end

  add_index "orders", ["package_id"], name: "index_orders_on_package_id", using: :btree

  create_table "packages", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "start_price_cents"
    t.integer  "minimum_price_cents"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "sold",                default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "reserved",            default: false
    t.integer  "price_now_cents"
    t.datetime "reserved_till"
  end

  add_foreign_key "orders", "packages"
end
