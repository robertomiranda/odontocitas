class SessionsController < ApplicationController


  def new
      paciente =  Paciente.find_by_correo(params[:username])

      if paciente && paciente.clave == params[:password]
        session[:user_id] = paciente.id
        session[:tipo] = "paciente"
        cookies.permanent[:login] = "P52543"+paciente.id.to_s

        if params[:security_access] == "7894563"
          redirect_to confirmar_cita_path({ id_cita_hora: params[:id_cita_hora], comentario_p_en: params[:comentario_p_en], motivo_p_en: params[:motivo_p_en]})
        else
          redirect_to paciente_url(paciente)
        end
        
      else
        @resultado = "El correo o la contrasena es incorrecta"
        render "new"
      end
    
  end

  def create

  	odonto =  Odontologo.find_by_correo(params[:username])

  	if odonto && odonto.clave == params[:password] && odonto.autorizado == 'si'
      session[:user_id] = odonto.id
      session[:tipo] = "odontologo"
      cookies.permanent[:login] ="O52543"+odonto.id.to_s
      redirect_to odontologo_url(odonto)
  	else
  		paciente = Paciente.find_by_correo(params[:username])

  		if paciente && paciente.clave == params[:password]
        session[:user_id] = paciente.id
        session[:tipo] = "paciente"
        cookies.permanent[:login] = "P52543"+paciente.id.to_s

        if params[:security_access] == "7894563"
          #redirect_to paciente_url(paciente)
          redirect_to confirmar_cita_path({ id_cita_hora: params[:id_cita_hora], comentario_p_en: params[:comentario_p_en], motivo_p_en: params[:motivo_p_en]})
        else
          redirect_to paciente_url(paciente)
        end
        
  		else

        #clinica = Clinica.find_by_correo(params[:username])

        #if clinica && clinica.clave == params[:password]
        #  session[:user_id] = clinica.id
        #  session[:tipo] = "clinica"
        #  cookies.permanent[:login] ="C52543"+clinica.id.to_s
        #  redirect_to clinica_url(clinica)
        #else
          @resultado = "El correo o la contrasena es incorrecta"
          render "new"
        #end
  		end

  	end


    #user = User.find_by_username(params[:username])
    #if user && user.authenticate(params[:password])
    #  session[:user_id] = user.id
    #  redirect_to root_url, alert: "Logged in!"
    #else
    #  redirect_to root_url, alert: "Username or Password was wrong"
    #end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
    cookies.delete :login
  end


  def recordar_clave

  end

  def restaurar_clave
    
    num1 = Random.rand(9)
    num2 = Random.rand(9)
    num3 = Random.rand(9)
    num4 = Random.rand(9)
    num5 = Random.rand(9)
    num6 = Random.rand(9)
    completo = num1.to_s+num2.to_s+ num3.to_s+ num4.to_s+ num5.to_s+ num6.to_s


    odonto = Odontologo.find_by_correo(params[:correo])
    if odonto  && odonto.autorizado == 'si'
      odonto.clave = completo
      if odonto.save
        enviar_correo_restaurar_clave params[:correo], completo
      end
      
    else
      paciente = Paciente.find_by_correo(params[:correo])

      if paciente 
        paciente.clave = completo
        if paciente.save
          enviar_correo_restaurar_clave params[:correo], completo
        end

      else

        clinica = Clinica.find_by_correo(params[:correo])

        if clinica 
          clinica.clave = completo

          if clinica.save
            enviar_correo_restaurar_clave params[:correo], completo
          end

        else
          render "new"
        end
      end
    
    end

  end


  def enviar_correo_restaurar_clave (correo,clave)

    cabezote = "&#161;Tu Clave se ha restaurado exitosamente&#33; "
    

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
          to "#{correo}"
          from 'Odontocitas <odontocitas@odontocitas.com>'
          subject 'Tu clave se ha restaurado'
          text_part do
            body 'Se cancelo tu cita'
          end
          html_part do
            content_type 'text/html; charset=UTF-8'
            body "<div style='margin:auto;width:551px;font-family:helvetica;color:#808080;'>"+
                    "<div style='background:#f37021; height:70px;padding:10px 0 0 0;'>"+
                      "<p style='width:333px;font-family:helvetica;font-size:15pt;padding:0 0 0 20px; float:left; color:white; margin: 10px 0 0 0; '>"+
                        cabezote+
                      "</p>"+
                      "<img src='http://odontocitas.com/assets/correos/logo_odonto_blanco_grande.png' style='vertical-align:middle;'/>"+
                    "</div>"+
                      "<div style='margin:30px 0 0 0;'>"+
                        "<p style='font-size:14pt'>"+
                        "Tu clave ha sido restaurada por :"+
                        "</p>"+
                        "<br>"+
                        "#{clave}"+
                        "<br>"+
                        "<br>"+
                      "</div>"+
                      "<p style='width:551px;'>"+
                        "Ingresa a tu perfil escribiendo tu correo y esta clave en el bot&#243;n superior derecho INGRESAR."+
                        "<br>"+  
                        "Al entrar a tu perfil dir&#237;gite al m&#243;dulo de configuraci&#243;n en donde podr&#225;s cambiar tu clave."+
                      "</p>"+
                      "<br>"+
                      "<p style='width:551px;'>"+
                        "Si tienes alguna pregunta por favor ll&#225;manos o escr&#237;benos un correo electr&#243;nico. <br>"+
                        "Nuestros datos de contacto est&#225;n al final de este mensaje"+
                      "</p>"+
                      "<br>"+
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
  

end
