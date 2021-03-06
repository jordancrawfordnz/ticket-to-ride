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

ActiveRecord::Schema.define(version: 20170213211917) do

  create_table "cities", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dealt_train_cars", force: :cascade do |t|
    t.integer  "player_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "train_car_type_id"
    t.index ["player_id"], name: "index_dealt_train_cars_on_player_id"
    t.index ["train_car_type_id"], name: "index_dealt_train_cars_on_train_car_type_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "current_player_id"
    t.boolean  "finished_action"
    t.index ["current_player_id"], name: "index_games_on_current_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.text     "name",         null: false
    t.integer  "score",        null: false
    t.text     "colour",       null: false
    t.integer  "game_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "train_pieces"
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  create_table "route_claims", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "route_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_route_claims_on_player_id"
    t.index ["route_id"], name: "index_route_claims_on_route_id"
  end

  create_table "route_types", force: :cascade do |t|
    t.string   "colour",                 null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "accepts_all_train_cars"
  end

  create_table "routes", force: :cascade do |t|
    t.integer  "pieces",        null: false
    t.integer  "city1_id",      null: false
    t.integer  "city2_id",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "route_type_id"
    t.integer  "svg_id"
    t.index ["city1_id"], name: "index_routes_on_city1_id"
    t.index ["city2_id"], name: "index_routes_on_city2_id"
    t.index ["route_type_id"], name: "index_routes_on_route_type_id"
  end

  create_table "train_car_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "total",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "wildcard"
    t.string   "colour",     null: false
  end

end
