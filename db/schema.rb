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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120615142118) do

  create_table "characters", :force => true do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.string   "name"
    t.string   "concept"
    t.text     "keeping_awake"
    t.text     "just_happened"
    t.text     "surface"
    t.text     "beneath"
    t.text     "path"
    t.integer  "discipline"
    t.integer  "exhaustion"
    t.integer  "madness"
    t.text     "e_talent"
    t.text     "m_talent"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "name"
    t.integer  "despair",    :default => 0, :null => false
    t.integer  "hope",       :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "gm_id"
  end

  create_table "plays", :force => true do |t|
    t.integer "user_id"
    t.integer "game_id"
    t.string  "character_name"
  end

  create_table "results", :force => true do |t|
    t.integer  "game_id"
    t.string   "winner"
    t.integer  "degree"
    t.string   "discipline"
    t.string   "exhaustion"
    t.string   "madness"
    t.string   "pain"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "dominating"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
