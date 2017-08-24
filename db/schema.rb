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

ActiveRecord::Schema.define(version: 20170824003903) do

  create_table "companies", force: :cascade do |t|
    t.string   "company"
    t.integer  "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods_people", force: :cascade do |t|
    t.integer "food_id"
    t.integer "person_id"
  end

  create_table "friends", force: :cascade do |t|
    t.integer "person_id"
    t.integer "friend_id"
    t.index ["friend_id", "person_id"], name: "index_friends_on_friend_id_and_person_id", unique: true
    t.index ["person_id", "friend_id"], name: "index_friends_on_person_id_and_friend_id", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.integer  "index"
    t.boolean  "has_died"
    t.string   "eyeColor"
    t.string   "gender"
    t.string   "email"
    t.string   "_id"
    t.string   "guid"
    t.string   "phone"
    t.string   "address"
    t.text     "about"
    t.string   "greeting"
    t.string   "registered"
    t.string   "balance"
    t.string   "picture"
    t.integer  "company_index"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
