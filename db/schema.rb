# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_23_045106) do

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token", default: ""
# ActiveRecord::Schema.define(version: 2020_07_25_060005) do

  create_table "brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "ancestry", null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.text "text", null: false
    t.index ["item_id"], name: "index_comments_on_item_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "item_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image", null: false
    t.bigint "item_id", null: false
    t.index ["item_id"], name: "index_item_images_on_item_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "brand_id", null: false
    t.bigint "category_id", null: false
    t.string "name", null: false
    t.integer "price", null: false
    t.text "text", null: false
    t.integer "condition", null: false
    t.datetime "completed_at"
    t.index ["brand_id"], name: "index_items_on_brand_id"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.index ["item_id"], name: "index_pets_on_item_id"
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "sendings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.integer "postal_code", null: false
    t.string "city", null: false
    t.string "block", null: false
    t.string "building", null: false
    t.string "roomnumber"
    t.string "telephone"
    t.index ["user_id"], name: "index_sendings_on_user_id"
  end

#   create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
#     t.string "nickname", null: false
#     t.string "last_name", null: false
#     t.string "firdt_name", null: false
#     t.string "last_name_kana", null: false
#     t.string "first_name_kana", null: false
#     t.string "birth_year", null: false
#     t.string "birth_month", null: false
#     t.string "birth_day", null: false
#     t.string "email", null: false
#     t.string "password", null: false
#     t.string "encrypted_password", default: "", null: false
#     t.string "reset_password_token"
#     t.datetime "reset_password_sent_at"
#     t.datetime "remember_created_at"
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: "", null: false
    t.string "lastname", limit: 11, default: "", null: false
    t.string "firstname", limit: 11, default: "", null: false
    t.string "lastname_kana", limit: 11, default: ""
    t.string "firstname_kana", limit: 11, default: ""
    t.date "birth_day"
    t.string "tel_num", limit: 11, default: ""
    t.string "send_lastname", limit: 11, default: ""
    t.string "send_firstname", limit: 11, default: ""
    t.string "send_lastname_kana", limit: 11, default: ""
    t.string "send_firstname_kana", limit: 11, default: ""
    t.integer "post_num"
    t.string "prefectures", limit: 11, default: ""
    t.string "city", limit: 11, default: ""
    t.string "address", limit: 11, default: ""
    t.string "address_2nd", limit: 11, default: ""
    t.index ["email"], name: "index_users_on_email", unique: true
  end

    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "users"
  add_foreign_key "comments", "items"
  add_foreign_key "comments", "users"
  add_foreign_key "item_images", "items"
  add_foreign_key "items", "brands"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "users"
  add_foreign_key "pets", "items"
  add_foreign_key "pets", "users"
  add_foreign_key "sendings", "users"
end
