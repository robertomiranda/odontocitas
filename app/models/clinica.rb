class Clinica < ActiveRecord::Base
	extend FriendlyId
	
  attr_accessible :ciudad, :clave, :correo, :direccion, :foto_perfil, :imagen1, :imagen2, :imagen3, :img_promocion, :lat, :long, :nombre, :perfil, :telefono, :zona , :slug


  mount_uploader :imagen1, ImageUploader 
  mount_uploader :imagen2, ImageUploader 
  mount_uploader :imagen3, ImageUploader 

  mount_uploader :img_promocion, ImageUploader 
  mount_uploader :foto_perfil, ImageUploader 
  has_many :clinicaxodontologos
  has_many :odontologos, :through => :clinicaxodontologos

  friendly_id :nombre, use: :slugged
end
