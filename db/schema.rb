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

ActiveRecord::Schema.define(version: 20160127170437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrateurs", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_token"
  end

  add_index "administrateurs", ["email"], name: "index_administrateurs_on_email", unique: true, using: :btree
  add_index "administrateurs", ["reset_password_token"], name: "index_administrateurs_on_reset_password_token", unique: true, using: :btree

  create_table "cadastres", force: :cascade do |t|
    t.string  "surface_intersection"
    t.float   "surface_parcelle"
    t.string  "numero"
    t.integer "feuille"
    t.string  "section"
    t.string  "code_dep"
    t.string  "nom_com"
    t.string  "code_com"
    t.string  "code_arr"
    t.text    "geometry"
    t.integer "dossier_id"
  end

  create_table "cerfas", force: :cascade do |t|
    t.string  "content"
    t.integer "dossier_id"
  end

  add_index "cerfas", ["dossier_id"], name: "index_cerfas_on_dossier_id", using: :btree

  create_table "champs", force: :cascade do |t|
    t.string  "value"
    t.integer "type_de_champ_id"
    t.integer "dossier_id"
  end

  create_table "commentaires", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.string   "body"
    t.integer  "dossier_id"
    t.datetime "updated_at", null: false
  end

  add_index "commentaires", ["dossier_id"], name: "index_commentaires_on_dossier_id", using: :btree

  create_table "dossiers", force: :cascade do |t|
    t.string   "description"
    t.boolean  "autorisation_donnees"
    t.string   "nom_projet"
    t.integer  "procedure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.integer  "user_id"
    t.text     "json_latlngs"
    t.boolean  "archived",             default: false
    t.boolean  "mandataire_social",    default: false
  end

  add_index "dossiers", ["procedure_id"], name: "index_dossiers_on_procedure_id", using: :btree
  add_index "dossiers", ["user_id"], name: "index_dossiers_on_user_id", using: :btree

  create_table "entreprises", force: :cascade do |t|
    t.string   "siren"
    t.integer  "capital_social"
    t.string   "numero_tva_intracommunautaire"
    t.string   "forme_juridique"
    t.string   "forme_juridique_code"
    t.string   "nom_commercial"
    t.string   "raison_sociale"
    t.string   "siret_siege_social"
    t.string   "code_effectif_entreprise"
    t.datetime "date_creation"
    t.string   "nom"
    t.string   "prenom"
    t.integer  "dossier_id"
  end

  create_table "etablissements", force: :cascade do |t|
    t.string  "siret"
    t.boolean "siege_social"
    t.string  "naf"
    t.string  "libelle_naf"
    t.string  "adresse"
    t.string  "numero_voie"
    t.string  "type_voie"
    t.string  "nom_voie"
    t.string  "complement_adresse"
    t.string  "code_postal"
    t.string  "localite"
    t.string  "code_insee_localite"
    t.integer "dossier_id"
    t.integer "entreprise_id"
  end

  create_table "exercices", force: :cascade do |t|
    t.string   "ca"
    t.datetime "dateFinExercice"
    t.integer  "date_fin_exercice_timestamp"
    t.integer  "etablissement_id"
  end

  create_table "france_connect_informations", force: :cascade do |t|
    t.string  "gender"
    t.string  "given_name"
    t.string  "family_name"
    t.date    "birthdate"
    t.string  "birthplace"
    t.string  "france_connect_particulier_id"
    t.integer "user_id"
    t.string  "email_france_connect"
  end

  create_table "gestionnaires", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "administrateur_id"
  end

  add_index "gestionnaires", ["email"], name: "index_gestionnaires_on_email", unique: true, using: :btree
  add_index "gestionnaires", ["reset_password_token"], name: "index_gestionnaires_on_reset_password_token", unique: true, using: :btree

  create_table "module_api_cartos", force: :cascade do |t|
    t.integer "procedure_id"
    t.boolean "use_api_carto",          default: false
    t.boolean "quartiers_prioritaires", default: false
    t.boolean "cadastre",               default: false
  end

  add_index "module_api_cartos", ["procedure_id"], name: "index_module_api_cartos_on_procedure_id", unique: true, using: :btree

  create_table "pieces_justificatives", force: :cascade do |t|
    t.string  "content"
    t.integer "dossier_id"
    t.integer "type_de_piece_justificative_id"
  end

  add_index "pieces_justificatives", ["type_de_piece_justificative_id"], name: "index_pieces_justificatives_on_type_de_piece_justificative_id", using: :btree

  create_table "procedures", force: :cascade do |t|
    t.string   "libelle"
    t.string   "description"
    t.string   "organisation"
    t.string   "direction"
    t.string   "lien_demarche"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "test"
    t.integer  "administrateur_id"
    t.boolean  "archived",          default: false
    t.boolean  "euro_flag",         default: false
    t.string   "logo"
  end

  create_table "quartier_prioritaires", force: :cascade do |t|
    t.string  "code"
    t.string  "nom"
    t.string  "commune"
    t.text    "geometry"
    t.integer "dossier_id"
  end

  create_table "rna_informations", force: :cascade do |t|
    t.string  "association_id"
    t.string  "titre"
    t.text    "objet"
    t.date    "date_creation"
    t.date    "date_declaration"
    t.date    "date_publication"
    t.integer "entreprise_id"
  end

  create_table "types_de_champ", force: :cascade do |t|
    t.string  "libelle"
    t.string  "type_champ"
    t.integer "order_place"
    t.integer "procedure_id"
    t.text    "description"
  end

  create_table "types_de_piece_justificative", force: :cascade do |t|
    t.string   "libelle"
    t.string   "description"
    t.boolean  "api_entreprise", default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "procedure_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                        default: "",      null: false
    t.string   "encrypted_password",           default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "siret"
    t.string   "loged_in_with_france_connect", default: "false"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "cerfas", "dossiers"
  add_foreign_key "commentaires", "dossiers"
  add_foreign_key "dossiers", "users"
end
