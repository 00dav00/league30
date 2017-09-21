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

ActiveRecord::Schema.define(version: 20170921124122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "phases", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position_in_tournament", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tournament_id"
    t.index ["tournament_id"], name: "index_phases_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "short_name", null: false
    t.string "name", null: false
    t.string "full_name", null: false
    t.string "logo_image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournament_contestants", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id", "tournament_id"], name: "index_tournament_contestants", unique: true
    t.index ["team_id"], name: "index_tournament_contestants_on_team_id"
    t.index ["tournament_id"], name: "index_tournament_contestants_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", null: false
    t.integer "required_teams", null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "contestants_count", default: 0
  end

  add_foreign_key "phases", "tournaments"
end
