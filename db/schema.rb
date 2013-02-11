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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130211034336) do

  create_table "dato_personals", :force => true do |t|
    t.string   "nombre"
    t.string   "apellidoPaterno"
    t.string   "apellidoMaterno"
    t.date     "fechaDeNacimiento"
    t.string   "curp"
    t.string   "genero"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "dependientes", :force => true do |t|
    t.integer  "dato_personal_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "dependientes_tutors", :id => false, :force => true do |t|
    t.integer "dependiente_id"
    t.integer "tutor_id"
  end

  create_table "perfils", :force => true do |t|
    t.string   "perfil"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "perfils_usuarios", :id => false, :force => true do |t|
    t.integer "usuario_id"
    t.integer "perfil_id"
  end

  create_table "tutors", :force => true do |t|
    t.string   "rfc"
    t.integer  "dato_personal_id"
    t.integer  "usuario_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "usuarios", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
