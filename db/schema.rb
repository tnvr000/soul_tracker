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

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "crdb_internal_region", ["aws-ap-south-1"]

  create_table "equipment", force: :cascade do |t|
    t.string "name"
    t.integer "equipment_type"
    t.integer "equipment_style"
    t.integer "equipment_class"
    t.integer "equipment_class_level"
    t.integer "level", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unique_key", null: false
    t.index ["unique_key"], name: "index_equipment_on_unique_key"
  end

  create_table "heros", force: :cascade do |t|
    t.string "name"
    t.integer "hero_class"
    t.integer "hero_type"
    t.integer "level"
    t.integer "stars"
    t.integer "hero_role"
    t.integer "hero_style"
    t.integer "combat_power"
    t.integer "hit_point"
    t.integer "defence"
    t.integer "attack"
    t.integer "speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count", default: 1
    t.string "unique_key", null: false
    t.index ["unique_key"], name: "index_heros_on_unique_key"
  end

end
