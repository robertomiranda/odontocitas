class Paciente < ActiveRecord::Base
	has_many :appointments
	has_many :odontologos, :through => :appointments
	attr_accessible :id,:celular, :clave, :correo, :nombre, :telefono, :usuario, :apellido,:genero,:como_se_entero,:fecha_nacimiento, :creado_por
end
