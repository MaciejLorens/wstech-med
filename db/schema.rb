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

ActiveRecord::Schema.define(version: 20190516140715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.integer  "quantity",                   null: false
    t.string   "color",                      null: false
    t.integer  "order_id",                   null: false
    t.boolean  "hidden",     default: false, null: false
    t.datetime "hidden_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product"
    t.string   "model"
    t.string   "options"
  end

  add_index "items", ["hidden"], name: "index_items_on_hidden", using: :btree
  add_index "items", ["order_id"], name: "index_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "number"
    t.integer  "user_id",                                   null: false
    t.integer  "purchaser_id",                              null: false
    t.datetime "delivery_request_date",                     null: false
    t.datetime "ready_to_delivery_at"
    t.datetime "delivered_at"
    t.datetime "deleted_at"
    t.integer  "deleted_by_id"
    t.string   "invoice_number"
    t.string   "serial_number"
    t.string   "shipping_address"
    t.string   "status",                default: "ordered", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "client_order_number"
    t.string   "suspend_message"
    t.string   "comment"
    t.string   "package_dimensions"
    t.string   "stages",                default: [],                     array: true
    t.string   "payment_comment"
    t.string   "shipping_comment"
  end

  add_index "orders", ["invoice_number"], name: "index_orders_on_invoice_number", using: :btree
  add_index "orders", ["number"], name: "index_orders_on_number", using: :btree
  add_index "orders", ["purchaser_id"], name: "index_orders_on_purchaser_id", using: :btree
  add_index "orders", ["serial_number"], name: "index_orders_on_serial_number", using: :btree
  add_index "orders", ["status"], name: "index_orders_on_status", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "purchasers", force: :cascade do |t|
    t.string   "name",                      null: false
    t.boolean  "hidden",    default: false, null: false
    t.datetime "hidden_at"
  end

  add_index "purchasers", ["hidden"], name: "index_purchasers_on_hidden", using: :btree
  add_index "purchasers", ["name"], name: "index_purchasers_on_name", using: :btree

  create_table "unseens", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "unseens", ["order_id"], name: "index_unseens_on_order_id", using: :btree
  add_index "unseens", ["user_id"], name: "index_unseens_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                         null: false
    t.string   "last_name",                          null: false
    t.string   "email",                              null: false
    t.string   "encrypted_password",                 null: false
    t.integer  "sign_in_count",      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "admin",              default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
