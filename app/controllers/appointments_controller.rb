class AppointmentsController < ApplicationController
  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appointments }
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appointment }
    end
  end

  # GET /appointments/new
  # GET /appointments/new.json
  def new
    @appointment = Appointment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @appointment }
    end
  end

  # GET /appointments/1/edit
  def edit
    @appointment = Appointment.find(params[:id])
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(params[:appointment])
    
    cita = @appointment
    respond_to do |format|
      if @appointment.save

        enviar_correo_cita_nueva_paciente cita
        enviar_correo_cita_nueva_odontologo cita 

        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render json: @appointment, status: :created, location: @appointment }
      else
        format.html { render action: "new" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end


  end

  # PUT /appointments/1
  # PUT /appointments/1.json
  def update

    @appointment = Appointment.find(params[:id])
    cita = @appointment
    estado =  params[:appointment][:estado]

    respond_to do |format|
      if @appointment.update_attributes(params[:appointment])

        case estado
          when "cancelada"
            enviar_correo_cancelada cita
          when "reagandada"
            enviar_correo_reagendada cita
          when "confirmada"
            enviar_correo_confirmada cita
          else
            #...
          end

        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url }
      format.json { head :no_content }
    end
  end

  def enviar_correo_cita_nueva_paciente cita

    cabezote = "&#161;Tienes una nueva cita&#33;"
    imagen = "<img src='http://odontocitas.com/#{cita.odontologo.image_url}' style='200px;height:220px; vertical-align:middle;'/>"
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
          to "#{cita.paciente.correo}"
          from 'Odontocitas <odontocitas@odontocitas.com>'
          subject 'Tienes una nueva cita'
          text_part do
            body 'Tienes una nueva cita'
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


  def enviar_correo_cita_nueva_odontologo cita

    cabezote = "&#161;Tienes una nueva cita&#33;"
    imagen = "<img src='http://odontocitas.com/#{cita.odontologo.image_url}' style='200px;height:220px; vertical-align:middle;'/>"
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
          to "#{cita.odontologo.correo}"
          from 'Odontocitas <odontocitas@odontocitas.com>'
          subject 'Tienes una nueva cita'
          text_part do
            body 'Tienes una nueva cita'
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
                        "Doctor  #{cita.odontologo.nombre} #{cita.odontologo.apellido}"+
                        "</p>"+
                        "<br>"+
                        "#{cita.paciente.nombre} #{cita.paciente.apellido} acaba de pedir una cita para #{cita.dia} de #{cita.mes_arreglado}, #{cita.hora_arreglada}"+
                        "<br>"+
                        "<ul>"+
                          "<li>Motivo de la consulta :  #{cita.motivo} </li>"+
                        "</ul>"+
                        "<br>"+
                        "<br>"+
                        "Entra a tu agenda para comfirmar y verificar la informaci&#243;n de tu paciente."+"<br>"+"<br>"+
                        "<br>"+
                        "<br>"+
                        "<p> Una vez confirmes la cita, enviaremos un correo electr&#243;nico al paciente inform&#225;ndole tu confirmaci&#243;n.</p>"+
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


  def enviar_correo_confirmada cita

    cabezote = "&#161;Tu Odontocita fue confirmada&#33;"
    imagen = "<img src='http://odontocitas.com/#{cita.odontologo.image_url}' style='200px;height:220px; vertical-align:middle;'/>"
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
          to "#{cita.paciente.correo}"
          from 'Odontocitas <odontocitas@odontocitas.com>'
          subject 'Se confirmo tu Odontocita'
          text_part do
            body 'Se confirmo tu Odontocita'
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
                        "<br>"+
                        "Tu odont&#243;logo  #{cita.odontologo.nombre} #{cita.odontologo.apellido} acaba de confirmar tu cita <br>"+
                        "Ac&#225; estan los detalles tu cita reagendada :"+
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

  def enviar_correo_cancelada cita

    cabezote = "&#161;Tu Odontocita fue Cancelada&#33; "
    imagen = "<img src='http://odontocitas.com/#{cita.odontologo.image_url}' style='200px;height:220px; vertical-align:middle;'/>"

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
          to "#{cita.paciente.correo}"
          from 'Odontocitas <odontocitas@odontocitas.com>'
          subject 'Tu Odontocita fue cancelada'
          text_part do
            body 'Se cancelo tu cita'
          end
          html_part do
            content_type 'text/html; charset=UTF-8'
            body "<div style='margin:auto;width:551px;font-family:helvetica;color:#808080;'>"+
                    "<div style='background:#f37021; height:50px;padding:10px 0 0 0;'>"+
                      "<p style='width:333px;font-family:helvetica;font-size:15pt;padding:0 0 0 20px; float:left; color:white; margin: 10px 0 0 0; '>"+
                        cabezote+
                      "</p>"+
                      "<img src='http://odontocitas.com/assets/correos/logo_odonto_blanco_grande.png' style='vertical-align:middle;'/>"+
                    "</div>"+
                      "<div style='margin:30px 0 0 0;'>"+
                        "<p style='font-size:14pt'>"+
                        "Hola #{cita.paciente.nombre} #{cita.paciente.apellido}"+
                        "</p>"+
                        "<br>"+
                        "Ac&#225; estan los detalles tu cita cancelada :"+
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
                        "Si deseas agendar una nueva Odontocita por favor entra a tu cuenta en <a href='http://odontocitas.com/'>Odontocitas.com</a>"+
                      "</p>"+
                      "<br>"+
                      "<br>"+
                      "<p style='width:551px;'>"+
                        "Si tienes alguna pregunta por favor ll&#225;manos o escr&#237;benos un correo electr&#243;nico. <br>"+
                        "Nuestros datos de contacto est&#225;n al final de este mensaje"+
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

  def enviar_correo_reagendada cita

    cabezote = "&#161;Tu Odontocita fue reagendada&#33; "
    imagen = "<img src='http://odontocitas.com/#{cita.odontologo.image_url}' style='200px;height:220px; vertical-align:middle;'/>"

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
          to "#{cita.paciente.correo}"
          from 'Odontocitas <odontocitas@odontocitas.com>'
          subject 'Tu Odontocita fue reagendada'
          text_part do
            body 'Se reagendo tu cita'
          end
          html_part do
            content_type 'text/html; charset=UTF-8'
            body "<div style='margin:auto;width:551px;font-family:helvetica;color:#808080;'>"+
                    "<div style='background:#FCCC6B; height:50px;padding:10px 0 0 0;'>"+
                      "<p style='width:333px;font-family:helvetica;font-size:15pt;padding:0 0 0 20px; float:left; color:white; margin: 10px 0 0 0; '>"+
                        cabezote+
                      "</p>"+
                      "<img src='http://odontocitas.com/assets/correos/logo_odonto_blanco_grande.png' style='vertical-align:middle;'/>"+
                    "</div>"+
                      "<div style='margin:30px 0 0 0;'>"+
                        "<p style='font-size:14pt'>"+
                        "Hola #{cita.paciente.nombre} #{cita.paciente.apellido}"+
                        "</p>"+
                        "<br>"+
                        "Ac&#225; estan los detalles tu cita reagendada :"+
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
                        "En las pr&#243;ximas horas recibiras un correo electr&#243;nico de tu odont&#243;logo confirmando tu nueva cita."+
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

end
