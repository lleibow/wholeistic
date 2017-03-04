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

ActiveRecord::Schema.define(version: 20170304213420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foods", force: :cascade do |t|
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "preferred",            default: false
    t.boolean  "dairy_free",           default: false
    t.boolean  "gluten_free",          default: false
    t.boolean  "nut_free",             default: false
    t.boolean  "pescatarian",          default: false
    t.boolean  "veg",                  default: false
    t.boolean  "vegan",                default: false
    t.string   "name"
    t.float    "serving_qty"
    t.float    "serving_unit"
    t.float    "serving_weight_grams"
    t.float    "calcium"
    t.float    "calories"
    t.float    "carbs"
    t.float    "copper"
    t.float    "choline"
    t.float    "dietary_fiber"
    t.float    "fat_mono"
    t.float    "fat_poly"
    t.float    "folate"
    t.float    "iron"
    t.float    "lutein"
    t.float    "manganese"
    t.float    "magnesium"
    t.float    "phosphorus"
    t.float    "potassium"
    t.float    "protein"
    t.float    "selenium"
    t.float    "sodium"
    t.float    "sugars"
    t.float    "vitamin_a"
    t.float    "vitamin_b6"
    t.float    "vitamin_b12"
    t.float    "vitamin_c"
    t.float    "vitamin_d"
    t.float    "vitamin_e"
    t.float    "vitamin_k"
    t.float    "zinc"
  end

  create_table "foods_users", force: :cascade do |t|
    t.integer  "food_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "gender"
    t.date     "date_of_birth"
    t.integer  "height_cm"
    t.integer  "weight_kg"
    t.boolean  "vegan"
    t.boolean  "veg"
    t.boolean  "dairy_free"
    t.boolean  "nut_free"
    t.boolean  "pescatarian"
    t.boolean  "gluten_free"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
