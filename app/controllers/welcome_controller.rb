class WelcomeController < ApplicationController


  def index
      
      #Appointment.cambiar_estado_asistida

  		@opciones_conoce = 		   [['---','---'],
                                   ['Correo Electronico','Correo Electronico'],
                                   ['Internet','Internet'],
                                   ['Radio','Radio'],
                                   [ 'Television','Television']] 
                                   
      #require 'elibom'
      #require "net/http"
      #require "uri"

      #Elibom.configure(
      #  :user => 'je.rodriguezcanon@gmail.com', 
      #  :api_password => '7oVY7AZ35k'
      #)

      #post_params = {"to" => "573008911930", "text" => "Esto es una prueba"}
      
      #uri = URI 'https://www.elibom.com/messages'

      #http = Net::HTTP.new(uri.host, uri.port)
      #http.use_ssl = true if uri.scheme == 'https'

      #resp = http.post_form(uri, post_params)

      #uri = URI.parse("https://www.elibom.com/messages")
      # Shortcut
      #response = Net::HTTP.post_form(uri, {"to" => "573008911930", "text" => "50","scheduleDate" => "2013-08-26 18:5"})

      #response = Net::HTTP.post_form(uri, {"to" => "573008911930", "text" => "Esto es una prueba"})

  end

  def show
    
  end

  def buscar_odontologo
    ciudad = params[:ciudad]
    especialidad = params[:especialidad]


    if ciudad == '--' and especialidad == '--'
      @odontologos = Odontologo.find(:all, conditions: {autorizado:'si'})
      
      #@odontologos.concat(Clinica.all)


    else

      if ciudad == '--'
        @odontologos = Odontologo.find(:all , conditions: {autorizado:'si', specialities: {especialidad: especialidad} }, joins: [:specialities])
      else
        if especialidad == '--'
          @odontologos = Odontologo.find(:all , conditions: {autorizado:'si',consultorios: { ciudad: ciudad} }, joins: [:consultorios])
        else
          @odontologos = Odontologo.find(:all , conditions: {autorizado:'si', consultorios: { ciudad: ciudad} ,specialities: {especialidad: especialidad} }, joins: [:specialities,:consultorios])
        end
      end

    end
    

    
  end
end
