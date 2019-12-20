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

ActiveRecord::Schema.define(version: 2019_12_19_230916) do

  create_table "headhunters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_headhunters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_headhunters_on_reset_password_token", unique: true
  end

  create_table "job_opportunities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "habilities"
    t.text "salary_range"
    t.integer "opportunity_level"
    t.date "end_date_opportunity"
    t.string "region"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "headhunter_id"
    t.index ["headhunter_id"], name: "index_job_opportunities_on_headhunter_id"
  end

  create_table "job_seekers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_job_seekers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_job_seekers_on_reset_password_token", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "nick_name"
    t.date "day_of_birth"
    t.string "education_level"
    t.text "description"
    t.text "experience"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "document"
    t.integer "job_seeker_id"
    t.index ["job_seeker_id"], name: "index_profiles_on_job_seeker_id"
  end

  create_table "subscription_comments", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "subscription_id"
    t.index ["subscription_id"], name: "index_subscription_comments_on_subscription_id", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "job_seeker_id"
    t.integer "job_opportunity_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_opportunity_id"], name: "index_subscriptions_on_job_opportunity_id"
    t.index ["job_seeker_id", "job_opportunity_id"], name: "index_subscriptions_on_job_seeker_id_and_job_opportunity_id", unique: true
    t.index ["job_seeker_id"], name: "index_subscriptions_on_job_seeker_id"
  end

  add_foreign_key "job_opportunities", "headhunters"
  add_foreign_key "profiles", "job_seekers"
  add_foreign_key "subscription_comments", "subscriptions"
  add_foreign_key "subscriptions", "job_opportunities"
  add_foreign_key "subscriptions", "job_seekers"
end
