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

ActiveRecord::Schema.define(version: 20160210214125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "initial_number_of_lives"
    t.string   "word_to_guess"
    t.integer  "user_id"
    t.boolean  "custom",                  default: false
    t.integer  "sender_id"
  end

  add_index "games", ["user_id"], name: "index_games_on_user_id", using: :btree

  create_table "guesses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "letter"
    t.integer  "game_id"
  end

  add_index "guesses", ["game_id"], name: "index_guesses_on_game_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "type"
    t.integer  "sender_id"
    t.integer  "receiver_id",                 null: false
    t.integer  "game_id"
    t.boolean  "read",        default: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.integer  "rank_points",     default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

  add_foreign_key "games", "users"
  add_foreign_key "guesses", "games"
end
