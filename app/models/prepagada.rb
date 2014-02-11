class Prepagada < ActiveRecord::Base
  belongs_to :odontologo
  attr_accessible :odontologo_id, :prepagada
end
