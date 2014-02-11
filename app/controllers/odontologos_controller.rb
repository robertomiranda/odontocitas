class OdontologosController < ApplicationController
  # GET /odontologos
  # GET /odontologos.json
  def index
    @odontologos = Odontologo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @odontologos }
    end
  end

  # GET /odontologos/1
  # GET /odontologos/1.json
  def show
    @odontologo = Odontologo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @odontologo }
    end
  end

  # GET /odontologos/new
  # GET /odontologos/new.json
  def new
    @odontologo = Odontologo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @odontologo }
    end
  end

  # GET /odontologos/1/edit
  def edit
    @odontologo = Odontologo.find(params[:id])
  end

  # POST /odontologos
  # POST /odontologos.json
  def create
    @odontologo = Odontologo.new(params[:odontologo])

    correo = @odontologo.correo
    clave = @odontologo.clave

    respond_to do |format|
      if @odontologo.save
        format.html { redirect_to @odontologo, notice: 'Odontologo was successfully created.' }
        format.json { render json: @odontologo, status: :created, location: @odontologo }
      else
        format.html { render action: "new" }
        format.json { render json: @odontologo.errors, status: :unprocessable_entity }
      end
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

      mail = Mail.deliver do
        to correo
        from 'Your Name <odontocitas@odontocitas.com>'
        subject 'Bienvenido a odontocitas'
        text_part do
          body 'Prueba Correo Odontologo'
        end
        html_part do
          content_type 'text/html; charset=UTF-8'
          body '<b>Quiero ver esto</b> tu clave es '+ clave
        end
      end
  end

  # PUT /odontologos/1
  # PUT /odontologos/1.json
  def update
    @odontologo = Odontologo.find(params[:id])

    respond_to do |format|
      if @odontologo.update_attributes(params[:odontologo])
        format.html { render json: @odontologo }
        format.json { render json: @odontologo  }
      else
        format.html { render text: "error" }
        format.json { render json: @odontologo.errors, status: :unprocessable_entity }
      end
    end
  end

  def cambiar_clave
    #@odontologo = Odontologo.find(params[:id])

    respond_to do |format|
     # if @odontologo.update_attributes(params[:odontologo])
     #   format.html { render json: @odontologo }
     #   format.json { render json: @odontologo  }
     # else
        format.html { render text: "error" }
        format.json { render json: @odontologo.errors, status: :unprocessable_entity }
     # end
    end
  end

  # DELETE /odontologos/1
  # DELETE /odontologos/1.json
  def destroy
    @odontologo = Odontologo.find(params[:id])
    @odontologo.destroy

    respond_to do |format|
      format.html { redirect_to odontologos_url }
      format.json { head :no_content }
    end
  end

  def quitar_horas_disponibles
      #params[:fecha_inicio],params[:hora_inicio], params[:minutos_inicio], params[:am_pm_inicio], params[:hora_final], params[:minutos_final], params[:am_pm_final], params[:se_repite], params[:dias], params[:fecha_final], params[:odontologo_id]
       
        hora_inicio = params[:hora_inicio]
        minutos_inicio = params[:minutos_inicio]
        am_pm_inicio = params[:am_pm_inicio]
        hora_final = params[:hora_final]
        minutos_final = params[:minutos_final]
        am_pm_final = params[:am_pm_final]
        odontologo_id = params[:odontologo_id]
        hora_inicio_i = 0
        hora_final_i = 0

        fecha_final = params[:fecha_final]
        fecha_inicio = params[:fecha_inicio]

        if am_pm_inicio == 'pm' and hora_inicio != '12'
              hora_inicio_i = hora_inicio.to_i + 12
              hora_inicio = hora_inicio_i.to_s
        end

        if am_pm_final == 'pm' and hora_final != '12'
          hora_final_i = hora_final.to_i + 12
          hora_final = hora_final_i.to_s
        end
        
        calculo_hora_ini = (hora_inicio.to_i * 60 ) + minutos_inicio.to_i
        calculo_hora_fin = (hora_final.to_i * 60 ) +  minutos_final.to_i

      # obj_horas_disponibles = {
      #      'hora'           => calculo_hora_ini,
      #      'mes'            => fecha_final[0],
      #      'dia'            => fecha_final[1],
      #      'ano'            => fecha_final[2],
      #      'odontologo_id'  => odontologo_id,
      #      'duracion'       => calculo_hora_fin
      #    }

      #    @horas_disponible = HorasDisponible.new(obj_horas_disponibles)
      #    @horas_disponible.save

      
      borrar_horas_por_fecha calculo_hora_ini, calculo_hora_fin, fecha_inicio, fecha_final ,odontologo_id, params[:dias]

       # @horas_elim.each do |hora|
       #   if calculo_hora_ini <= hora.hora.to_i and hora.hora.to_i < calculo_hora_fin
       #     hora.destroy
       #   end
       # end


        respond_to do |format|
            format.html { render json: @horas_elim }
            format.json { render json: @horas_elim }
        end

    end
  
end



#aux
def agregar_odontologo1

end

  def agendar
      @odontologo = Odontologo.new(params[:odontologo])

    respond_to do |format|
      if @odontologo.save
        format.html { redirect_to @odontologo, notice: 'Odontologo was successfully created.' }
        format.json { render json: @odontologo, status: :created, location: @odontologo }
      else
        format.html { render action: "new" }
        format.json { render json: @odontologo.errors, status: :unprocessable_entity }
      end
    end
  end

def borrar_horas_por_fecha (hora_ini, hora_fin, fecha_inicio, fecha_final ,odontologo_id,dias)
    fecha_inicio = fecha_inicio.split("/")
    fecha_final = fecha_final.split("/")

    diferencia_d = fecha_final[1].to_i - fecha_inicio[1].to_i

    if diferencia_d == 0 and fecha_inicio[0].to_i == fecha_inicio[0].to_i # si es para hoy 

        #if fecha_final[0].tr('0', '')
          
        #end

        fecha_inic = ""
        dia_inic = ""


        if fecha_final[0].to_i > 9 
          fecha_inic = fecha_final[0] 
        else
          fecha_inic = fecha_final[0].tr('0', '')  
        end 

        if fecha_final[1].to_i > 9 
          dia_inic = fecha_final[1] 
        else
          dia_inic = fecha_final[1].tr('0', '')  
        end 


        @horas_elim = HorasDisponible.where(mes: fecha_inic ,dia: dia_inic,ano:fecha_final[2],odontologo_id:odontologo_id)

        @horas_elim.each do |hora|
          if hora_ini <= hora.hora.to_i and hora.hora.to_i < hora_fin
            hora.destroy
          end
        end

    else 
        fecha_i = Date.new(fecha_inicio[2].to_i,fecha_inicio[0].to_i,fecha_inicio[1].to_i)
        fecha_f = Date.new(fecha_final[2].to_i,fecha_final[0].to_i,fecha_final[1].to_i)

          while !(fecha_i === fecha_f)
            if dias.nil? 
              @horas_elim = HorasDisponible.where(mes: fecha_i.mon ,dia: fecha_i.mday,ano:fecha_i.year,odontologo_id:odontologo_id)
              @horas_elim.each do |hora|
                if hora_ini <= hora.hora.to_i and hora.hora.to_i < hora_fin
                  hora.destroy
                end
              end

            else
                if dias.include?(fecha_i.wday.to_s) 
                    @horas_elim = HorasDisponible.where(mes: fecha_i.mon ,dia: fecha_i.mday,ano:fecha_i.year,odontologo_id:odontologo_id)
                    @horas_elim.each do |hora|
                      if hora_ini <= hora.hora.to_i and hora.hora.to_i < hora_fin
                        hora.destroy
                      end
                    end
                end
            end

              fecha_i = fecha_i +1 ;
          end

          if dias.nil?
                    @horas_elim = HorasDisponible.where(mes: fecha_i.mon ,dia: fecha_i.mday,ano:fecha_i.year,odontologo_id:odontologo_id)
                    @horas_elim.each do |hora|
                      if hora_ini <= hora.hora.to_i and hora.hora.to_i < hora_fin
                        hora.destroy
                      end
                    end
          else
              if dias.include?(fecha_i.wday.to_s) 
                    @horas_elim = HorasDisponible.where(mes: fecha_i.mon ,dia: fecha_i.mday,ano:fecha_i.year,odontologo_id:odontologo_id)
                    @horas_elim.each do |hora|
                      if hora_ini <= hora.hora.to_i and hora.hora.to_i < hora_fin
                        hora.destroy
                      end
                    end
              end
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
          format.html { redirect_to root_url }
          
          
        else
          format.html { redirect_to root_url }
        end
  end



