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

ActiveRecord::Schema.define(version: 20151015162426) do

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"

  create_table "educations", force: :cascade do |t|
    t.date     "start"
    t.date     "end"
    t.string   "name"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "educations", ["user_id"], name: "index_educations_on_user_id"

  create_table "experiences", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.string   "name"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id"

  create_table "galleries", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "cover"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.boolean  "public"
  end

  add_index "galleries", ["user_id"], name: "index_galleries_on_user_id"

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "file_meta"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "gallery_id"
    t.datetime "exif_date"
    t.string   "exif_exposure_time"
    t.float    "exif_f_number"
  end

  add_index "images", ["gallery_id"], name: "index_images_on_gallery_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.boolean  "public"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "simple_user_infos", force: :cascade do |t|
    t.string   "info"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "simple_user_infos", ["user_id"], name: "index_simple_user_infos_on_user_id"

  create_table "skills", force: :cascade do |t|
    t.string   "skill"
    t.integer  "in_love_index"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "skill_index"
  end

  add_index "skills", ["in_love_index"], name: "index_skills_on_in_love_index"
  add_index "skills", ["skill_index"], name: "index_skills_on_skill_index"
  add_index "skills", ["user_id"], name: "index_skills_on_user_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.integer  "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggings", ["image_id"], name: "index_taggings_on_image_id"
  add_index "taggings", ["post_id"], name: "index_taggings_on_post_id"
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "remember_digest"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "real_name"
    t.datetime "birth_date"
    t.string   "phone"
  end

  add_index "users", ["email"], name: "index_users_on_email"

end
