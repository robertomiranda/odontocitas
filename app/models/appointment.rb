class Appointment < ActiveRecord::Base
	  belongs_to :odontologo
  	belongs_to :paciente
  	attr_accessible :id,:ano, :dia, :mes, :odontologo_id, :paciente_id, :hora ,:tipo_consulta , :comentarios, :motivo , :modo_pago, :medio_pago, :duracion, :estado

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


  	def mes_arreglado
  		case mes
  			when '1'
  				return 'Enero'
  			when '2'
  				return 'Febrero'
  			when '3'
  				return 'Marzo'
  			when '4'
  				return 'Abril'
  			when '5'
  				return 'Mayo'
  			when '6'
  				return 'Junio'
  			when '7'
  				return 'Julio'
  			when '8'
  				return 'Agosto'
  			when '9'
  				return 'Septiembre'
  			when '10'
  				return 'Octubre'
  			when '11'
  				return 'Noviembre'
  			when '12'
  				return 'Diciembre'
  		end	
  		
  	end

  	def self.cambiar_estado_asistida


      correo =""
      date = Time.now

      Appointment.where(estado: 'confirmada').each do |cita|
      
      Appointment.all.each do |cita|

      #cita = Appointment.find(338)
        otra = cita.hora.to_f/60
        res = otra.to_s.split('.')

        case res[1]
          when '0'
            res[1] = '0'
          when '25'
            res[1] = '15'
          when '5'
            res[1] = '30'
          when '75'
            res[1] = '45'
        end

        
        
        date_cita = Time.new(cita.ano.to_i, cita.mes.to_i, cita.dia.to_i, res[0].to_i , res[1].to_i, 0)

        dif_horas = ((date_cita - date) / 60 / 60).round(3)
        dif_horas_a = ((date - date_cita) / 60 / 60).round(3)


        if 9.956 < dif_horas && dif_horas < 10.03

        ##prueba 
        #if cita.dia.to_s == dia.to_s && cita.mes.to_s == date.month.to_s && cita.ano.to_s == date.year.to_s


            if cita.paciente.correo
              correo = cita.paciente.correo
            end

              require 'mail'
              Mail.defaults do
                delivery_method :smtp, { :address   => "smtp.sendgrid.net",
                                         :port      => 587,
                                         :domain    => "odontocitas.com",
                                         :user_name => "odontocitas",
                                         :password  => "qwer4321",
                                         :authentication => 'plain',
                                         :enable_starttls_auto => true }
              end

              cabezote = "&#161;Recordatorio Cita&#33;"
              imagen = "<img src='http://odontocitas.com/#{cita.odontologo.image_url}' style='200px;height:220px; vertical-align:middle;'/>"
              
              mail = Mail.deliver do
                to "correo"
                from 'Your Name <odontocitas@odontocitas.com>'
                subject 'Recordatorio Cita'
                text_part do
                  body 'Prueba Correo Odontologo'
                end
                html_part do
                    content_type 'text/html; charset=UTF-8'
                    body "<div style='margin:auto;width:551px;font-family:helvetica;color:#808080;'>"+
                            "<div style='background:#00a5e3; height:50px;padding:10px 0 0 0;'>"+
                              "<p style='width:333px;font-family:helvetica;font-size:15pt;padding:0 0 0 20px; float:left; color:white; margin: 10px 0 0 0; '>"+
                                cabezote+
                              "</p>"+
                              "<img src='http://odontocitas.com/assets/correos/logo_odonto_blanco_grande.png' style='vertical-align:middle;'/>"+
                            "</div>"+
                              "<div style='margin:30px 0 0 0;'>"+
                                "<p style='font-size:14pt'>"+
                                "Hola #{cita.paciente.nombre} #{cita.paciente.apellido}"+
                                "</p>"+
                                "No olvides la cita que tienes con tu odont&#243;logo  #{cita.odontologo.nombre} #{cita.odontologo.apellido}<br>"+
                                "Ac&#225; estan los detalles tu cita :"+
                                "<br>"+
                                "<br>"+
                                "<br>"+
                              "</div>"+
                              "<div style='width:550px; height:300px;'>"+
                                "<div style='width:200px;height:300px; float:left; text-align:center;'>"+
                                    imagen+"<br>"+
                                    "<a href='http://odontocitas.com/doctor/#{cita.odontologo.usuario}'>Ver perfil</a>"+
                                "</div>"+
                                "<div style='width:270px; height:300px;float:left;'>"+
                                    "<br>"+
                                    "<br>"+
                                    "<br>"+
                                    "<strong> Nombre Odont&#243;logo : </strong>#{cita.odontologo.nombre} #{cita.odontologo.apellido} <br> <br>"+
                                    "<strong> Fecha y hora : </strong>#{cita.dia} de #{cita.mes_arreglado} del #{cita.ano} a las #{cita.hora_arreglada} <br> <br>" +
                                    "<strong> Direcci&#243;n : </strong>#{cita.odontologo.consultorios[0].direccion } <br> <br>"+
                                    "<strong> Tel&#233;fono : </strong>#{cita.odontologo.consultorios[0].telefono } <br>"+
                                "</div>"+
                              "</div>"+
                              "<p style='width:551px;'>"+
                                "&#191; Necesitas reagendar o cancelar tu cita &#63; <br> Simplemente entra a tu cuenta en  <a href='http://odontocitas.com/'>Odontocitas.com</a>"+
                              "</p>"+
                              "<br>"+
                              "<br>"+
                              "<p style='font-size:14pt'>"+
                              "Gracias"+
                              "</p>"+
                              "<br>"+
                              "<br>"+
                              "<strong>Servicio al cliente : </strong>"+
                              "<a href='mailto:http://odontocitas.com/doctor/#{cita.odontologo.usuario}'>atencion@odontocitas.com</a> <br>"+
                              "<strong>Tel&#233;fono celular : </strong>318 304 5981"+
                              "<br>"+
                              "<br>"+
                              "<img src='http://odontocitas.com/assets/correos/foother_correos.jpg' style='200px;height:220px; vertical-align:middle;'/>"
                          "</div>"


                  end
              end
        end



        if 2.0 < dif_horas_a 
            cita.estado = 'asistio'
            cita.save
        end


      end

    end
      

  	end
  	
end
