class PacientesController < ApplicationController

  # GET /pacientes
  # GET /pacientes.json
  def index
    @pacientes = Paciente.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pacientes }
    end
  end

  # GET /pacientes/1
  # GET /pacientes/1.json
  def show
    @paciente = Paciente.find(params[:id])
    @arreglo = Array.new

    @paciente.appointments.each do |cita|
      cita.odontologo.specialities.each do |especialidad|
          if !@arreglo.include?(especialidad.especialidad)
              @arreglo.push especialidad.especialidad
          end
            
      end 
    end

    @arreglo.uniq

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paciente }
    end
  end

  # GET /pacientes/new
  # GET /pacientes/new.json
  def new

    @paciente = Paciente.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paciente }
    end
  end

  # GET /pacientes/1/edit
  def edit
    @paciente = Paciente.find(params[:id])
  end

  # POST /pacientes
  # POST /pacientes.json
  def create
    @paciente = Paciente.new(params[:paciente])

    paciente = @paciente
    respond_to do |format|
      if @paciente.save

        enviar_correo_nuevo_paciente paciente

        format.html { redirect_to @paciente, notice: 'Paciente was successfully created.' }
        format.json { render json: @paciente, status: :created, location: @paciente }
      else
        format.html { render action: "new" }
        format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end



  end

  # PUT /pacientes/1
  # PUT /pacientes/1.json
  def update
    @paciente = Paciente.find(params[:id])

    respond_to do |format|
      if @paciente.update_attributes(params[:paciente])
        format.html { redirect_to @paciente, notice: 'Paciente was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pacientes/1
  # DELETE /pacientes/1.json
  def destroy
    @paciente = Paciente.find(params[:id])
    @paciente.destroy

    respond_to do |format|
      format.html { redirect_to pacientes_url }
      format.json { head :no_content }
    end
  end


  def enviar_mensaje

    require 'net/http'
    require "uri"

    num1 = Random.rand(9)
    num2 = Random.rand(9)
    num3 = Random.rand(9)
    num4 = Random.rand(9)
    completo = num1.to_s+num2.to_s+ num3.to_s+ num4.to_s
    url = URI.parse('http://api.infobip.com/api/v3/sendsms/plain?user=colmedia&password=colmedia&sender=Odontocitas&SMSText=bienvenido+a+odontocitas+su+codigo+es+'+completo+'+&GSM=57'+params[:celular])
    #req = Net::HTTP::Get.new(url)
    response = Net::HTTP.get_response(url)

    respond_to do |format|
      format.html { render text: completo }
    end

  end 


  def agregar_paciente
    params[:nombre] 
    params[:apellido]
    params[:genero]
    params[:correo]
    params[:clave]
    params[:celular]
    params[:como_se_entero]

    fecha_nacimiento = params[:dia] +'/'+ params[:mes] +'/'+ params[:ano]

        paciente = {
          "nombre" => params[:nombre],
          "correo" => params[:correo],
          "clave"  => params[:clave],
          "celular"=> params[:celular],
          "telefono"=> 'borrar',
          "usuario"=> 'borrar',
          "apellido"=> params[:apellido],
          "genero"=> params[:genero],
          "como_se_entero"=> params[:como_se_entero],
          "fecha_nacimiento"=> fecha_nacimiento
        }

        @paciente_s = Paciente.new(paciente)
        pacien = @paciente_s
        if @paciente_s.save 

          correo = @paciente_s.correo
          clave = @paciente_s.clave

          enviar_correo_nuevo_paciente pacien
          
          if params[:security_access] == "7894563"
            redirect_to login_path({:id_cita_hora => params[:id_cita_hora] , :security_access => '7894563' , :username => correo,:password => clave, comentario_p_en: params[:comentario_p_en], motivo_p_en: params[:motivo_p_en]})
          else
            redirect_to login_path({:id_cita_hora => params[:id_cita_hora] , :username => correo,:password => clave, comentario_p_en: params[:comentario_p_en], motivo_p_en: params[:motivo_p_en]})
          end
        end

  end


  def enviar_correo_nuevo_paciente paciente

    cabezote = "&#161;Bienvenido a Odontocitas &#33;"
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
          to "#{paciente.correo}"
          from 'Odontocitas <odontocitas@odontocitas.com>'
          subject 'Bienvenido a odontocitas'
          text_part do
            body 'Bienvenido a odontocitas'
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
                        "Hola #{paciente.nombre} #{paciente.apellido}"+
                        "</p>"+
                        "<br>"+
                        "Te damos la bienvenida a este gran servicio&#33; A trav&#233;s de Odontocitas podr&#225;s:"+
                        "<br>"+
                        "<br>"+
                        "<ul>"+
                          "<li>Agendar tus citas a traves de internet.</li>"+
                          "<li>Regendar o cancelar tus citas si es necesario.</li>"+
                          "<li>Recibir recordatorios en tu correo electr&#243;nico</li>"+
                          "<li>ver tu historial de todas tus citas odontol&#243;gicas.</li>"+
                        "</ul>"+
                        "<br>"+
                        "<br>"+
                        "Para entrar a Odontocitas y disfrutar de nuestros beneficios solo tienes que ir a nuestra p&#225;gina de internet utilizando:"+
                      "</div>"+
                      "<br>"+
                      "<p style='padding:30px; background:#f37021;color:white;'>"+
                        "Tu correo electr&#243;nico: #{paciente.correo} <br>"+
                        "Tu clave: #{paciente.clave} <br>"+
                      "</p>"+
                      "<br>"+
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
                      "<img src='http://odontocitas.com/assets/correos/foother_correos.jpg' style='200px;height:220px; vertical-align:middle;'/>"+
                  "</div>"


          end
      end

  end

end




private 

def enviar_correo
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
        to 'santiago.varon@gmail.com'
        from 'Your Name <odontocitas@odontocitas.com>'
        subject 'prueba email'
        text_part do
          body 'Prueba de texto '
        end
        html_part do
          content_type 'text/html; charset=UTF-8'
          body '<b>Quiero ver esto</b>'
        end
      end

end


