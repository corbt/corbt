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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131216041324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "incidents", force: true do |t|
    t.text     "blob"
    t.integer  "incidentId"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "region"
    t.text     "weather"
    t.text     "traffic"
  end

  create_table "traffic_readings", force: true do |t|
    t.string   "label"
    t.text     "reading"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weather_reading_id"
    t.string   "region"
  end

  add_index "traffic_readings", ["weather_reading_id"], name: "index_traffic_readings_on_weather_reading_id", using: :btree

  create_table "usenet_lists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "num_threads"
    t.integer  "threads_count"
  end

  create_table "usenet_posts", force: true do |t|
    t.string   "author"
    t.date     "date"
    t.boolean  "corbitt"
    t.text     "content"
    t.integer  "usenet_thread_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usenet_posts", ["usenet_thread_id"], name: "index_usenet_posts_on_usenet_thread_id", using: :btree

  create_table "usenet_threads", force: true do |t|
    t.integer  "usenet_list_id"
    t.string   "thread_id"
    t.string   "title"
    t.date     "date"
    t.integer  "num_posts"
    t.integer  "num_authors"
    t.integer  "num_corbitt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  add_index "usenet_threads", ["usenet_list_id"], name: "index_usenet_threads_on_usenet_list_id", using: :btree

  create_table "weather_readings", force: true do |t|
    t.text     "reading"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
