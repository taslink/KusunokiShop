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

ActiveRecord::Schema.define(version: 20161129093308) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "addressee"
    t.string   "order_email"
    t.string   "zipcode"
    t.string   "prefecture_name"
    t.string   "city"
    t.string   "street"
    t.string   "building"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cart_pockets", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "cart_pocket_id"
    t.integer  "product_id"
    t.string   "product_type"
    t.integer  "count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "orderdetails", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.string   "product_type"
    t.integer  "count"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "address_id",     null: false
    t.string   "payment_type",   null: false
    t.string   "shipping_type",  null: false
    t.integer  "amount",         null: false
    t.integer  "pay_commission", null: false
    t.integer  "postage",        null: false
    t.integer  "add_amount",     null: false
    t.integer  "tax",            null: false
    t.integer  "total_amount",   null: false
    t.string   "note"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "prefectures", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_code"
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.string   "product_type"
    t.string   "jan_code"
    t.string   "main_image"
    t.string   "sub1_image"
    t.string   "sub2_image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "sort_no"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
