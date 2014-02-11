class HorasDisponible < ActiveRecord::Base
  attr_accessible :ano, :hora, :mes, :odontologo_id, :duracion , :dia , :id
  belongs_to :odontologos

 	def hora_arreglada
	 	hora_f = hora.to_f/60
	 	dec = hora_f.to_s.split('.')

	 	case dec[1]
		 	when '0'
		 		dec[1] = '00'
		 	when '25'
		 		dec[1] = '15'
		 	when '5'
		 		dec[1] = '30'
		 	when '75'
		 		dec[1] = '45'
	 	end

	 	if dec[0].to_i < 13
			 return " #{dec[0]}:#{dec[1]} am"		
	 	else
	 		dec[0] = dec[0].to_i
	 		dec[0] = dec[0] - 12
	 		return " #{dec[0]}:#{dec[1]} pm"
	 	end 	
  	end


end
