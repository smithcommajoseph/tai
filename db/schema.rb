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

ActiveRecord::Schema.define(:version => 20110729232850) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "active",               :default => false
    t.text     "stream_url"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
    t.string   "oauth_token_verifier"
    t.text     "oauth_authorize_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insult_adjectives", :force => true do |t|
    t.string   "adjective"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insult_nouns", :force => true do |t|
    t.string   "noun"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", :force => true do |t|
    t.string   "to"
    t.string   "insult"
    t.string   "t"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
