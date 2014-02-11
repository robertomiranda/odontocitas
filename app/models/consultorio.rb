class Consultorio < ActiveRecord::Base
  belongs_to :odontologo
  attr_accessible :ciudad, :direccion, :odontologo_id, :imagen1, :imagen2, :imagen3, :lat, :long, :nombre, :zona ,:telefono
  mount_uploader :imagen1, ImageUploader 
  mount_uploader :imagen2, ImageUploader 
  mount_uploader :imagen3, ImageUploader 
end
