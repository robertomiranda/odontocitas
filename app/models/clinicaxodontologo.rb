class Clinicaxodontologo < ActiveRecord::Base
	belongs_to :clinica
  	belongs_to :odontologo

  	attr_accessible :clinica_id, :odontologo_id
end
