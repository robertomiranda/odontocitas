class HorasDisponiblesController < ApplicationController
  require 'date'
  # GET /horas_disponibles
  # GET /horas_disponibles.json
  def index
    @horas_disponibles = HorasDisponible.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @horas_disponibles }
    end
  end

  # GET /horas_disponibles/1
  # GET /horas_disponibles/1.json
  def show
    @horas_disponible = HorasDisponible.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @horas_disponible }
    end
  end

  # GET /horas_disponibles/new
  # GET /horas_disponibles/new.json
  def new
    @horas_disponible = HorasDisponible.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @horas_disponible }
    end
  end

  # GET /horas_disponibles/1/edit
  def edit
    @horas_disponible = HorasDisponible.find(params[:id])
  end

  # POST /horas_disponibles
  # POST /horas_disponibles.json
  def create


    calcular_horas params[:tiempo_cita], params[:fecha_inicio],params[:hora_inicio], params[:minutos_inicio], params[:am_pm_inicio], params[:hora_final], params[:minutos_final], params[:am_pm_final], params[:se_repite], params[:dias], params[:fecha_final], params[:odontologo_id]
    #obj_horas_disponibles = {
    #  'hora'           => params[:hora],
    #  'mes'            => params[:mes],
    #  'ano'            => params[:ano],
    #  'odontologo_id'  => params[:odontologo_id]
    #}


    #@horas_disponible = HorasDisponible.new(obj_horas_disponibles)

    respond_to do |format|
      if 4 == 4
        format.html { redirect_to horas_disponibles_path, notice: 'Horas disponible was successfully created.' }
        format.json { render json: @horas_disponible, status: :created, location: @horas_disponible }
      else
        format.html { render action: "new" }
        format.json { render json: @horas_disponible.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /horas_disponibles/1
  # PUT /horas_disponibles/1.json
  def update
    @horas_disponible = HorasDisponible.find(params[:id])

    respond_to do |format|
      if @horas_disponible.update_attributes(params[:horas_disponible])
        format.html { redirect_to @horas_disponible, notice: 'Horas disponible was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @horas_disponible.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horas_disponibles/1
  # DELETE /horas_disponibles/1.json
  def destroy
    @horas_disponible = HorasDisponible.find(params[:id])
    @horas_disponible.destroy

    respond_to do |format|
      format.html { redirect_to horas_disponibles_url }
      format.json { head :no_content }
    end
  end
end





private 

def calcular_horas (tiempo_cita,fecha_inicio,hora_inicio,minutos_inicio,am_pm_inicio,hora_final,minutos_final,am_pm_final,se_repite,dias,fecha_final,odontologo_id)
    horas = calculo_horas tiempo_cita,hora_inicio,minutos_inicio,am_pm_inicio,hora_final,minutos_final,am_pm_final


    #fecha_inicial = fecha_inicio.split("/")
    #fecha_final = fecha_final.split("/") 

    generar_horas horas, fecha_inicio, fecha_final,tiempo_cita,odontologo_id,dias

   # horas.each do |x|  
   #    obj_horas_disponibles = {
   #       'hora'           => x,
   #       'mes'            => fecha_inicial[0],
   #       'dia'            => fecha_inicial[1],
   #       'ano'            => fecha_inicial[2],
   #       'odontologo_id'  => params[:odontologo_id],
   #       'duracion'       => tiempo_cita
   #     }

   #     @horas_disponible = HorasDisponible.new(obj_horas_disponibles)
   #     @horas_disponible.save
   # end
    
   
end

def calculo_horas (tiempo_cita,hora_inicio,minutos_inicio,am_pm_inicio,hora_final,minutos_final,am_pm_final)
    
      hora_inicio_i = 0
      hora_final_i = 0

    if am_pm_inicio == 'am' and hora_inicio == '12'
        hora_inicio_i = hora_inicio.to_i + 12
        hora_inicio = hora_inicio_i.to_s
    end

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


    horas = Array.new
    #horas.push calculo_hora_ini


    calculo_hora_ini_i  = calculo_hora_ini.to_i

    while calculo_hora_ini_i < calculo_hora_fin.to_i
        diferencia = calculo_hora_fin.to_i - calculo_hora_ini_i
        
        if diferencia.to_i >= tiempo_cita.to_i
          horas.push calculo_hora_ini_i
        end

        calculo_hora_ini_i =  calculo_hora_ini_i + tiempo_cita.to_i
        #if calculo_hora_ini_i == 120
        #  asdasd
        #end
        
    end

    return horas

end

def generar_horas (horas, fecha_inicio, fecha_final ,tiempo_cita,odontologo_id,dias)
    fecha_inicial = fecha_inicio.split("/")
    fecha_final = fecha_final.split("/")

    diferencia_d = fecha_final[1].to_i - fecha_inicial[1].to_i



    if diferencia_d == 0 and fecha_inicial[0].to_i == fecha_final[0].to_i # si es para hoy 
        horas.each do |x|  

          fecha_inic = ""
          dia_inic = ""

          if fecha_inicial[0].to_i > 9 
            fecha_inic = fecha_inicial[0] 
          else
            fecha_inic = fecha_inicial[0].tr('0', '')  
          end 

          if fecha_inicial[1].to_i > 9 
            dia_inic = fecha_inicial[1] 
          else
            dia_inic = fecha_inicial[1].tr('0', '')  
          end 
          
          

           obj_horas_disponibles = {
              'hora'           => x,
              'mes'            => fecha_inic,
              'dia'            => dia_inic,
              'ano'            => fecha_inicial[2],
              'odontologo_id'  => odontologo_id,
              'duracion'       => tiempo_cita
            }

            @horas_disponible = HorasDisponible.new(obj_horas_disponibles)
            @horas_disponible.save
        end
    else 
      
      fecha_i = Date.new(fecha_inicial[2].to_i,fecha_inicial[0].to_i,fecha_inicial[1].to_i)
      fecha_f = Date.new(fecha_final[2].to_i,fecha_final[0].to_i,fecha_final[1].to_i)

          while !(fecha_i === fecha_f)
            if dias.nil? 
                horas.each do |x|  
                   obj_horas_disponibles = {
                      'hora'           => x,
                      'mes'            => fecha_i.mon,
                      'dia'            => fecha_i.mday,
                      'ano'            => fecha_i.year,
                      'odontologo_id'  => odontologo_id,
                      'duracion'       => tiempo_cita
                    }

                    @horas_disponible = HorasDisponible.new(obj_horas_disponibles)
                    @horas_disponible.save
                end
            else
                if dias.include?(fecha_i.wday.to_s) 
                    horas.each do |x|  
                       obj_horas_disponibles = {
                          'hora'           => x,
                          'mes'            => fecha_i.mon,
                          'dia'            => fecha_i.mday,
                          'ano'            => fecha_i.year,
                          'odontologo_id'  => odontologo_id,
                          'duracion'       => tiempo_cita
                        }

                        @horas_disponible = HorasDisponible.new(obj_horas_disponibles)
                        @horas_disponible.save
                    end
                end
            end

              fecha_i = fecha_i +1 ;
          end

          if dias.nil?
              horas.each do |x|  
                  obj_horas_disponibles = {
                      'hora'           => x,
                      'mes'            => fecha_i.mon,
                      'dia'            => fecha_i.mday,
                      'ano'            => fecha_i.year,
                      'odontologo_id'  => odontologo_id,
                       'duracion'       => tiempo_cita
                  }

                  @horas_disponible = HorasDisponible.new(obj_horas_disponibles)
                  @horas_disponible.save
              end
          else
              if dias.include?(fecha_i.wday.to_s) 
                  horas.each do |x|  
                      obj_horas_disponibles = {
                          'hora'           => x,
                          'mes'            => fecha_i.mon,
                          'dia'            => fecha_i.mday,
                          'ano'            => fecha_i.year,
                          'odontologo_id'  => odontologo_id,
                           'duracion'       => tiempo_cita
                      }

                      @horas_disponible = HorasDisponible.new(obj_horas_disponibles)
                      @horas_disponible.save
                  end
              end
          end

           #d_f = Date.new(2013,7,7)
           #Sun, 07 Jul 2013 
           # d = Date.parse('3rd Feb 2001')
           #=> #<Date: 2001-02-03 ...>
           # d.year                       #=> 2001
           # d.mon                        #=> 2
           # d.mday                       #=> 3
           # d.wday                       #=> 6
           # d += 1                       #=> #<Date: 2001-02-04 ...>
           # d.strftime('%a %d %b %Y')    #=> "Sun 04 Feb 2001"

    end



end