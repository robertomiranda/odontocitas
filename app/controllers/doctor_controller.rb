class DoctorController < ApplicationController
  def index
    
  end

  def show
  	@odontologo = Odontologo.find(params[:id])
  	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @odontologo }
    end
  end
  
  def agendar_cita
    
    @hora_de_la_cita = HorasDisponible.find(params[:id_cita_hora])
    @odontologo = Odontologo.find( @hora_de_la_cita.odontologo_id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @odontologo }
    end

  end

  def confirmar_cita

    @hora_de_la_cita = HorasDisponible.find(params[:id_cita_hora])
    @comentario_p = params[:comentario_p_en]
    @motivo_cita = params[:motivo_p_en]
    @odontologo = Odontologo.find( @hora_de_la_cita.odontologo_id)
    

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @odontologo }
      end

    
  end

  def enviar_correo_registro odontologo

    cabezote = "&#161;Bienvenido a Odontocitas&#33;"
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

      mail = Mail.deliver do
          to "#{odontologo.correo}"
          from 'Odontocitas <odontocitas@odontocitas.com>'
          subject 'Bienvenido a Odontocitas'
          text_part do
            body 'Bienvenido a Odontocitas'
          end
          html_part do
            content_type 'text/html; charset=UTF-8'
            body "<div style='margin:auto;width:551px;font-family:helvetica;color:#808080;'>"+
                    "<div style='background:#254861; height:50px;padding:10px 0 0 0;'>"+
                      "<p style='width:333px;font-family:helvetica;font-size:15pt;padding:0 0 0 20px; float:left; color:white; margin: 10px 0 0 0; '>"+
                        cabezote+
                      "</p>"+
                      "<img src='http://odontocitas.com/assets/correos/logo_odonto_blanco_grande.png' style='vertical-align:middle;'/>"+
                    "</div>"+
                      "<div style='margin:30px 0 0 0;'>"+
                        "<p style='font-size:14pt'>"+
                        "Doctor  #{odontologo.nombre} #{odontologo.apellido}"+
                        "</p>"+
                        "<br>"+
                        "Gracias por tu inter&#233;s en Odontocitas.com"+
                        "<br>"+
                        "Espera la llamada de nuestro asesor para concretar el d&#237;a y la hora de nuestra visita."+
                        "<br>"+
                        "Queremos mostrarle con mayor detalle el poder de esta herramienta que esta pensada en optimizar la "+
                        "administraci&#243;n del consultorio de los odont&#243;logos"+
                        "<br>"+
                        "<br>"+
                        "Cordial Saludo"+
                      "</div>"+
                      "<p style='font-size:14pt'>"+
                      "Gracias"+
                      "</p>"+
                      "<br>"+
                      "<br>"+
                      "<strong>Servicio al cliente : </strong>"+
                      "<a href='mailto:atencion@odontocitas.com'>atencion@odontocitas.com</a> <br>"+
                      "<strong>Tel&#233;fono celular : </strong>318 304 5981"+
                      "<br>"+
                      "<br>"+
                      "<img src='http://odontocitas.com/assets/correos/foother_correos.jpg' style='200px;height:220px; vertical-align:middle;'/>"
                  "</div>"


          end
      end

  end

  def agregar_odontologo

    odontologo = {
            'nombre'           => params[:nombre],
            'apellido'            => params[:apellido],
            'celular'            => params[:celular],
            'clave'            => params[:clave],
            'correo'  => params[:correo],
            'especialidad'=> params[:especialidad],
            'telefono' => params[:telefono],
            'fecha_nacimiento' => params[:dia]+'/'+params[:mes]+'/'+params[:ano]
          }

        @odonto = Odontologo.new(odontologo)
        odontolo = @odonto
        if @odonto.save

          enviar_correo_registro odontolo
          respond_to do |format|
              format.html { redirect_to gracias_por_registrarte_path }
          end
        else
          respond_to do |format|
              format.html { redirect_to root_url }
          end
        end
  end

end
