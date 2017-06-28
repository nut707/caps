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

ActiveRecord::Schema.define(version: 20170310085606) do

  create_table "activity_directions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "activity_directions_projects", id: false, force: :cascade do |t|
    t.integer "activity_direction_id", limit: 4, null: false
    t.integer "project_id",            limit: 4, null: false
  end

  create_table "activity_directions_researches", id: false, force: :cascade do |t|
    t.integer "activity_direction_id", limit: 4
    t.integer "research_id",           limit: 4
  end

  add_index "activity_directions_researches", ["activity_direction_id"], name: "index_activity_directions_researches_on_activity_direction_id", using: :btree
  add_index "activity_directions_researches", ["research_id"], name: "index_activity_directions_researches_on_research_id", using: :btree

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id",    limit: 4
    t.string   "auditable_type",  limit: 255
    t.integer  "associated_id",   limit: 4
    t.string   "associated_type", limit: 255
    t.integer  "user_id",         limit: 4
    t.string   "user_type",       limit: 255
    t.string   "username",        limit: 255
    t.string   "action",          limit: 255
    t.text     "audited_changes", limit: 65535
    t.integer  "version",         limit: 4,     default: 0
    t.string   "comment",         limit: 255
    t.string   "remote_address",  limit: 255
    t.string   "request_uuid",    limit: 255
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "courses", force: :cascade do |t|
    t.text     "title",              limit: 65535
    t.integer  "project_id",         limit: 4
    t.integer  "lvl",                limit: 4
    t.text     "profile_podgotovki", limit: 65535
    t.integer  "duration",           limit: 4
    t.text     "desc",               limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "edu_program_id",     limit: 4
  end

  create_table "courses_languages", id: false, force: :cascade do |t|
    t.integer "language_id", limit: 4
    t.integer "course_id",   limit: 4
  end

  add_index "courses_languages", ["course_id"], name: "index_courses_languages_on_course_id", using: :btree
  add_index "courses_languages", ["language_id"], name: "index_courses_languages_on_language_id", using: :btree

  create_table "edu_programs", force: :cascade do |t|
    t.integer  "project_id",           limit: 4
    t.text     "name",                 limit: 65535
    t.integer  "type_pr",              limit: 4
    t.integer  "forma",                limit: 4
    t.text     "profile_podgotovki",   limit: 65535
    t.text     "lanuages",             limit: 65535
    t.text     "code_spec",            limit: 65535
    t.text     "second_diplom_univer", limit: 65535
    t.integer  "initial_edu_lvl",      limit: 4
    t.text     "other_requirements",   limit: 65535
    t.integer  "price",                limit: 4
    t.integer  "duration",             limit: 4
    t.text     "degree",               limit: 65535
    t.date     "date_start_enrolment"
    t.date     "date_start_education"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.text     "code",                 limit: 65535
    t.text     "desc",                 limit: 65535
    t.text     "desc_audience",        limit: 65535
    t.text     "online_courses",       limit: 65535
    t.integer  "students_count",       limit: 4,     default: 0, null: false
  end

  create_table "edu_programs_languages", id: false, force: :cascade do |t|
    t.integer "language_id",    limit: 4
    t.integer "edu_program_id", limit: 4
  end

  add_index "edu_programs_languages", ["edu_program_id"], name: "index_edu_programs_languages_on_edu_program_id", using: :btree
  add_index "edu_programs_languages", ["language_id"], name: "index_edu_programs_languages_on_language_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "description",    limit: 65535
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "participant_id", limit: 4
    t.integer  "project_id",     limit: 4
    t.integer  "status",         limit: 4,     default: 0
    t.text     "report",         limit: 65535
    t.datetime "report_date"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "expense_docs", force: :cascade do |t|
    t.integer  "planned_expense_id", limit: 4
    t.integer  "reserve_doc_id",     limit: 4
    t.date     "date"
    t.string   "number",             limit: 255
    t.string   "cfo",                limit: 255
    t.string   "contragent",         limit: 255
    t.string   "payment_purpose",    limit: 255
    t.decimal  "sum",                              precision: 10
    t.string   "responsible",        limit: 255
    t.text     "comment",            limit: 65535
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "expense_docs", ["planned_expense_id"], name: "index_expense_docs_on_planned_expense_id", using: :btree
  add_index "expense_docs", ["reserve_doc_id"], name: "index_expense_docs_on_reserve_doc_id", using: :btree

  create_table "expense_items", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.text     "name",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "expense_periods", force: :cascade do |t|
    t.date     "start"
    t.date     "finish"
    t.string   "name",       limit: 255
    t.integer  "project_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "expense_periods", ["project_id"], name: "index_expense_periods_on_project_id", using: :btree

  create_table "external_authors", force: :cascade do |t|
    t.string   "last_name",      limit: 255
    t.string   "first_name",     limit: 255
    t.string   "middle_name",    limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "publication_id", limit: 4
  end

  add_index "external_authors", ["publication_id"], name: "index_external_authors_on_publication_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "nationalities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "profile_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "other_events", force: :cascade do |t|
    t.integer  "project_id",                  limit: 4
    t.text     "name",                        limit: 65535
    t.integer  "price",                       limit: 4
    t.text     "expected_result_for_project", limit: 65535
    t.text     "expected_result_for_caps",    limit: 65535
    t.text     "desc",                        limit: 65535
    t.text     "target_audience",             limit: 65535
    t.text     "desc_of_zadel",               limit: 65535
    t.text     "promotion_plan",              limit: 65535
    t.text     "comparison_with_analogues",   limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "participants", force: :cascade do |t|
    t.integer "project_id", limit: 4
    t.integer "profile_id", limit: 4
    t.integer "role_id",    limit: 4
    t.integer "status",     limit: 4
  end

  add_index "participants", ["profile_id"], name: "index_participants_on_profile_id", using: :btree
  add_index "participants", ["project_id"], name: "index_participants_on_project_id", using: :btree
  add_index "participants", ["role_id"], name: "index_participants_on_role_id", using: :btree

  create_table "planned_expenses", force: :cascade do |t|
    t.integer  "expense_period_id", limit: 4
    t.integer  "expense_item_id",   limit: 4
    t.decimal  "value",                       precision: 10
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "planned_expenses", ["expense_item_id"], name: "index_planned_expenses_on_expense_item_id", using: :btree
  add_index "planned_expenses", ["expense_period_id"], name: "index_planned_expenses_on_expense_period_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",              limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "last_name",            limit: 255
    t.string   "first_name",           limit: 255
    t.string   "middle_name",          limit: 255
    t.string   "latin_name",           limit: 255
    t.datetime "birthday"
    t.string   "place_of_work",        limit: 255
    t.string   "working_postition",    limit: 255
    t.string   "education_university", limit: 255
    t.integer  "education_graduation", limit: 4
    t.string   "academic_degree",      limit: 255
    t.integer  "science_degree",       limit: 4
    t.string   "academic_title",       limit: 255
    t.text     "academic_awards",      limit: 65535
    t.string   "academic_membership",  limit: 255
    t.integer  "science_degree_year",  limit: 4
    t.integer  "labour_market",        limit: 4
    t.integer  "monograph_amount",     limit: 4
    t.integer  "index_hirsch_rinc",    limit: 4
    t.integer  "index_hirsch_scopus",  limit: 4
    t.integer  "index_hirsch_wos",     limit: 4
    t.string   "wos_researcher_id",    limit: 255
    t.string   "scopus_author_id",     limit: 255
    t.string   "phone",                limit: 255
    t.string   "email_contact",        limit: 255
    t.string   "citizenship",          limit: 255
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "profiles_publications", id: false, force: :cascade do |t|
    t.integer "profile_id",     limit: 4, null: false
    t.integer "publication_id", limit: 4, null: false
  end

  add_index "profiles_publications", ["profile_id", "publication_id"], name: "index_profiles_publications_on_profile_id_and_publication_id", using: :btree
  add_index "profiles_publications", ["publication_id", "profile_id"], name: "index_profiles_publications_on_publication_id_and_profile_id", unique: true, using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "type",                          limit: 255
    t.string   "title",                         limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "status",                        limit: 4,     default: 0, null: false
    t.text     "objective",                     limit: 65535
    t.text     "description",                   limit: 65535
    t.text     "results",                       limit: 65535
    t.text     "attracting_additional_funding", limit: 65535
    t.text     "experience",                    limit: 65535
    t.text     "resources",                     limit: 65535
    t.integer  "from",                          limit: 4
    t.integer  "to",                            limit: 4
  end

  create_table "projects_publications", id: false, force: :cascade do |t|
    t.integer "project_id",     limit: 4, null: false
    t.integer "publication_id", limit: 4, null: false
  end

  add_index "projects_publications", ["project_id", "publication_id"], name: "index_projects_publications_on_project_id_and_publication_id", unique: true, using: :btree
  add_index "projects_publications", ["publication_id", "project_id"], name: "index_projects_publications_on_publication_id_and_project_id", unique: true, using: :btree
  add_index "projects_publications", ["publication_id"], name: "index_projects_publications_on_publication_id", unique: true, using: :btree

  create_table "projects_science_branches", id: false, force: :cascade do |t|
    t.integer "project_id",        limit: 4, null: false
    t.integer "science_branch_id", limit: 4, null: false
  end

  create_table "publications", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.integer  "year",                 limit: 4
    t.string   "url",                  limit: 255
    t.string   "title_izdanie",        limit: 255
    t.string   "url_izdanie",          limit: 255
    t.integer  "issn",                 limit: 8
    t.integer  "isbn",                 limit: 8
    t.integer  "citations_rinc",       limit: 4
    t.integer  "citations_scopus",     limit: 4
    t.integer  "citations_wos",        limit: 4
    t.integer  "citations_scopus_wos", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "author_id",            limit: 4
    t.boolean  "indexed_rinc"
    t.boolean  "indexed_scopus"
    t.boolean  "indexed_wos"
    t.integer  "quartile_scopus",      limit: 4
    t.integer  "quartile_wos",         limit: 4
    t.boolean  "affiliated_fefu"
  end

  add_index "publications", ["title"], name: "index_publications_on_title", using: :btree

  create_table "rates", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "desc",       limit: 65535
    t.float    "exp_val_1y", limit: 24
    t.float    "exp_val_2y", limit: 24
    t.float    "exp_val_3y", limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "researches", force: :cascade do |t|
    t.text     "theme",                         limit: 65535
    t.integer  "project_id",                    limit: 4
    t.text     "key_words",                     limit: 65535
    t.text     "statement_of_research_problem", limit: 65535
    t.text     "aims_and_objectives",           limit: 65535
    t.text     "desc_research",                 limit: 65535
    t.text     "desc_methods",                  limit: 65535
    t.text     "expected_results",              limit: 65535
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "researches_science_branches", id: false, force: :cascade do |t|
    t.integer "research_id",       limit: 4
    t.integer "science_branch_id", limit: 4
  end

  add_index "researches_science_branches", ["research_id"], name: "index_researches_science_branches_on_research_id", using: :btree
  add_index "researches_science_branches", ["science_branch_id"], name: "index_researches_science_branches_on_science_branch_id", using: :btree

  create_table "reserve_docs", force: :cascade do |t|
    t.integer  "planned_expense_id", limit: 4
    t.date     "date"
    t.string   "number",             limit: 255
    t.string   "cfo",                limit: 255
    t.string   "contragent",         limit: 255
    t.string   "payment_purpose",    limit: 255
    t.decimal  "sum",                              precision: 10
    t.date     "from"
    t.date     "to"
    t.string   "responsible",        limit: 255
    t.text     "comment",            limit: 65535
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "reserve_docs", ["planned_expense_id"], name: "index_reserve_docs_on_planned_expense_id", using: :btree

  create_table "role_field_values", force: :cascade do |t|
    t.text     "value",          limit: 65535
    t.integer  "role_field_id",  limit: 4
    t.integer  "participant_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "role_field_values", ["participant_id"], name: "index_role_field_values_on_participant_id", using: :btree
  add_index "role_field_values", ["role_field_id"], name: "index_role_field_values_on_role_field_id", using: :btree

  create_table "role_fields", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "role_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "role_fields", ["role_id"], name: "index_role_fields_on_role_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "science_branches", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "stays", force: :cascade do |t|
    t.integer  "profile_id", limit: 4
    t.date     "from"
    t.date     "to"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "fio",            limit: 255
    t.integer  "edu_program_id", limit: 4
    t.integer  "edu_year",       limit: 4
    t.integer  "birthday_year",  limit: 4
    t.integer  "nationality_id", limit: 4
    t.integer  "ege_mark",       limit: 4
    t.integer  "forma",          limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "fio",            limit: 255
    t.integer  "course_id",      limit: 4
    t.integer  "birthday_year",  limit: 4
    t.integer  "nationality_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "username",               limit: 255
    t.boolean  "ldap_user",                          default: false, null: false
    t.integer  "role",                   limit: 4,   default: 0,     null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "expense_periods", "projects"
  add_foreign_key "external_authors", "publications"
  add_foreign_key "planned_expenses", "expense_items"
  add_foreign_key "planned_expenses", "expense_periods"
  add_foreign_key "reserve_docs", "planned_expenses"
end
