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

ActiveRecord::Schema[7.1].define(version: 2024_09_28_170808) do
  create_schema "crdb_internal"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "crdb_internal_region", ["aws-ap-south-1"]

  create_table "equipment", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "name"
    t.bigint "equipment_type"
    t.bigint "equipment_style"
    t.bigint "equipment_class"
    t.bigint "equipment_class_level"
    t.bigint "level", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unique_key", null: false

    t.unique_constraint ["unique_key"], name: "index_equipment_on_unique_key"
  end

  create_table "heros", id: :bigint, default: -> { "unique_rowid()" }, force: :cascade do |t|
    t.string "name"
    t.bigint "hero_class"
    t.bigint "hero_type"
    t.bigint "level"
    t.bigint "stars"
    t.bigint "hero_role"
    t.bigint "hero_style"
    t.bigint "combat_power"
    t.bigint "hit_point"
    t.bigint "defence"
    t.bigint "attack"
    t.bigint "speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "count", default: 1
    t.string "unique_key", null: false

    t.unique_constraint ["unique_key"], name: "index_heros_on_unique_key"
  end

end
