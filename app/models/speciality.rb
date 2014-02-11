class Speciality < ActiveRecord::Base
  belongs_to :odontologo
  attr_accessible :especialidad, :odontologo_id
end
