# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_26_101517) do
  create_table "boards", force: :cascade do |t|
    t.integer "height"
    t.integer "width"
    t.integer "bombs_count"
    t.boolean "playing", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cells", force: :cascade do |t|
    t.integer "line_id", null: false
    t.boolean "bomb", default: false
    t.integer "close_bombs", default: 0
    t.boolean "flag", default: false
    t.boolean "discovered", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_id"], name: "index_cells_on_line_id"
  end

  create_table "leaderboards", force: :cascade do |t|
    t.string "name"
    t.integer "clicks"
    t.integer "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lines", force: :cascade do |t|
    t.integer "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_lines_on_board_id"
  end

  add_foreign_key "cells", "lines"
  add_foreign_key "lines", "boards"
end
