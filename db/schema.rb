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

ActiveRecord::Schema.define(:version => 20110430171337) do

  create_table "events", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "category"
    t.string   "name"
    t.text     "description"
    t.integer  "place_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["movie_id"], :name => "movie_id"
  add_index "events", ["place_id"], :name => "place_id"

  create_table "images", :force => true do |t|
    t.string   "filename"
    t.text     "source_image_url"
    t.string   "caption"
    t.string   "credit"
    t.integer  "entity_id"
    t.string   "entity_type"
    t.text     "source_page_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["entity_id"], :name => "entity_id"
  add_index "images", ["entity_type"], :name => "entity_type"

  create_table "locales", :force => true do |t|
    t.string   "name"
    t.string   "country"
    t.text     "description"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", :force => true do |t|
    t.string   "name"
    t.string   "tagline"
    t.text     "description"
    t.integer  "year"
    t.string   "url"
    t.string   "wikipedia_url"
    t.integer  "length"
    t.string   "genre"
    t.string   "subgenre"
    t.decimal  "rating"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.string   "address"
    t.string   "zip"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.integer  "locale_id"
    t.string   "url"
    t.float    "lat"
    t.float    "lng"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "places", ["cached_slug"], :name => "cached_slug"
  add_index "places", ["category"], :name => "category"
  add_index "places", ["locale_id"], :name => "locale_id"

end
