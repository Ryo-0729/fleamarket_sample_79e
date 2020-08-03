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

ActiveRecord::Schema.define(version: 2020_07_25_060005) do

  create_table "brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
  end

  create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "customer_id", null: false
    t.string "card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "ancestry"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.bigint "item_id"
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
    t.integer "user_id", null: false
    t.string "name", null: false
    t.text "text", null: false
    t.bigint "category_id", null: false
    t.string "brand"
    t.integer "condition_id", null: false
    t.integer "postage_payer_id", null: false
    t.integer "prefecture_id", null: false
    t.integer "preparation_id", null: false
    t.integer "price", null: false
    t.timestamp "completed_at"
    t.integer "buyer_id"
    t.integer "seller_id"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.bigint "item_id", null: false
    t.index ["item_id"], name: "index_pets_on_item_id"
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "sendings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
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

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "password", default: "", null: false
    t.string "password_confirmation", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name_kana", default: "", null: false
    t.string "first_name_kana", default: "", null: false
    t.string "birthyear", default: "", null: false
    t.string "birthmonth", default: "", null: false
    t.string "birthday", default: "", null: false
    t.string "telephone", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.text "icon"
    t.text "text"
    t.string "post_first_name", default: "", null: false
    t.string "post_last_name", default: "", null: false
    t.string "post_first_name_kana", default: "", null: false
    t.string "post_last_name_kana", default: "", null: false
    t.string "post_cord", default: "", null: false
    t.string "city", default: "", null: false
    t.string "address", default: "", null: false
    t.text "building"
    t.string "prefecture_id", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "users"
  add_foreign_key "comments", "items"
  add_foreign_key "comments", "users"
  add_foreign_key "item_images", "items"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "users"
  add_foreign_key "pets", "items"
  add_foreign_key "pets", "users"
  add_foreign_key "sendings", "users"
end
