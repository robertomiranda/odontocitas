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

ActiveRecord::Schema.define(:version => 20130822194430) do

  create_table "appointments", :force => true do |t|
    t.integer  "odontologo_id"
    t.integer  "paciente_id"
    t.string   "hora"
    t.string   "dia"
    t.string   "mes"
    t.string   "ano"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "motivo"
    t.string   "modo_pago"
    t.string   "medio_pago"
    t.string   "tipo_consulta"
    t.text     "comentarios"
    t.string   "duracion"
    t.string   "estado"
  end

  create_table "consulta", :force => true do |t|
    t.string   "consulta_aceptada"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "odontologo_id"
  end

  create_table "consultorios", :force => true do |t|
    t.string   "nombre"
    t.string   "direccion"
    t.string   "ciudad"
    t.string   "zona"
    t.string   "lat"
    t.string   "long"
    t.string   "imagen1"
    t.string   "imagen2"
    t.string   "imagen3"
    t.string   "telefono"
    t.integer  "odontologo_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "horas_disponibles", :force => true do |t|
    t.integer  "odontologo_id"
    t.string   "hora"
    t.string   "dia"
    t.string   "mes"
    t.string   "ano"
    t.string   "duracion"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "medio_pagos", :force => true do |t|
    t.string   "medio_pago"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "odontologo_id"
  end

  create_table "odontologos", :force => true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "correo"
    t.string   "especialidad"
    t.string   "clave"
    t.string   "celular"
    t.string   "telefono"
    t.string   "direccion"
    t.string   "usuario"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "image"
    t.string   "fecha_nacimiento"
    t.text     "perfil"
    t.text     "facebook"
    t.text     "twitter"
    t.text     "linkedin"
    t.string   "youtube"
    t.string   "estudio"
    t.string   "membrecia"
    t.string   "slug"
    t.string   "autorizado"
    t.string   "web"
    t.string   "genero"
  end

  create_table "pacientes", :force => true do |t|
    t.string   "nombre"
    t.string   "correo"
    t.string   "clave"
    t.string   "celular"
    t.string   "telefono"
    t.string   "usuario"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "apellido"
    t.string   "genero"
    t.string   "como_se_entero"
    t.string   "fecha_nacimiento"
    t.string   "creado_por"
  end

  create_table "prepagadas", :force => true do |t|
    t.string   "prepagada"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "odontologo_id"
  end

  create_table "specialities", :force => true do |t|
    t.string   "especialidad"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "odontologo_id"
  end

end
