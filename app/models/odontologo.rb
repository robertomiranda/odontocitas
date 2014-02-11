class Odontologo < ActiveRecord::Base
	extend FriendlyId

	attr_accessible :apellido, :celular, :clave, :correo, :direccion, :especialidad, :nombre, :telefono, :usuario, :image,:fecha_nacimiento, :perfil, :facebook, :twitter, :linkedin, :youtube, :web ,:estudio , :membrecia, :slug, :id , :autorizado , :genero
	
	has_many :prepagadas
	has_many :consulta
	has_many :medio_pagos
	has_many :consultorios
	has_many :appointments
	has_many :specialities
	has_many :horas_disponibles
	has_many :pacientes, :through => :appointments

	has_many :clinicaxodontologos
  	has_many :clinicas, :through => :clinicaxodontologos

	mount_uploader :image, ImageUploader 

	friendly_id :usuario, use: :slugged
end

public

def nombre_completo
	nombre+" "+apellido
end
