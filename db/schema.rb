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

ActiveRecord::Schema.define(version: 20170112232334) do

  create_table "dealt_train_cars", force: :cascade do |t|
    t.integer  "player_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "train_car_type_id"
    t.index ["player_id"], name: "index_dealt_train_cars_on_player_id"
    t.index ["train_car_type_id"], name: "index_dealt_train_cars_on_train_car_type_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.text     "name",         null: false
    t.decimal  "score"
    t.text     "colour",       null: false
    t.integer  "game_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "train_pieces"
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  create_table "train_car_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "total",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
