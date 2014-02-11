class MedioPago < ActiveRecord::Base
  belongs_to :odontologo
  attr_accessible :odontologo_id, :medio_pago
end
