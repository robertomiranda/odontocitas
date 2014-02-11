class Consultum < ActiveRecord::Base
  belongs_to :odontologo
  attr_accessible :consulta_aceptada, :odontologo_id
end
