class AdministradorController < ApplicationController
  layout "administrador"
  before_filter :authorize

  def index
    @odontologos = Odontologo.all
    @pacientes = Paciente.all
    @citas = Appointment.all

    @online = 0
    @offline = 0

    @noasistio = 0
    @asistio = 0
    @confirmada = 0
    @porconfirmar = 0
    @reagandada = 0
    @cancelada = 0

    @citas.each do |cita|
      if cita.tipo_consulta == "online"
        @online = @online + 1
      end

      if cita.tipo_consulta == "offline"
        @offline = @offline + 1
      end

      if cita.estado == "noasistio"
        @noasistio = @noasistio + 1
      end

      if cita.estado == "asistio"
        @asistio = @asistio + 1
      end

      if cita.estado == "confirmada"
        @confirmada = @confirmada + 1
      end

      if cita.estado == "porconfirmar"
        @porconfirmar = @porconfirmar + 1
      end

      if cita.estado == "reagandada"
        @reagandada = @reagandada + 1
      end

      if cita.estado == "cancelada"
        @cancelada = @cancelada + 1
      end
    end

  end

  def odontologos
  	@odontologos = Odontologo.all
  end

  def show_odontologo
  	@odontologo = Odontologo.find(params[:id])

  	@online = 0
  	@offline = 0

  	@noasistio = 0
  	@asistio = 0
  	@confirmada = 0
  	@porconfirmar = 0
  	@reagandada = 0
    @cancelada = 0

  	@pacientes = Appointment.where("odontologo_id = ?", params[:id]).group("paciente_id")

	@odontologo.appointments.each do |cita|
		if cita.tipo_consulta == "online"
			@online = @online + 1
		end

		if cita.tipo_consulta == "offline"
			@offline = @offline + 1
		end

		if cita.estado == "noasistio"
			@noasistio = @noasistio + 1
		end

		if cita.estado == "asistio"
			@asistio = @asistio + 1
		end

		if cita.estado == "confirmada"
			@confirmada = @confirmada + 1
		end

		if cita.estado == "porconfirmar"
			@porconfirmar = @porconfirmar + 1
		end

		if cita.estado == "reagandada"
			@reagandada = @reagandada + 1
		end

		if cita.estado == "cancelada"
			@cancelada = @cancelada + 1
		end
	end


  end

  def edit_odontologo
  	@odontologo = Odontologo.find(params[:id])
  end

  def activar_odontologo
    @odontologo = Odontologo.find(params[:id])
  end

  def pacientes
    @pacientes = Paciente.all
  end

  def show_paciente
  	@paciente = Paciente.find(params[:id])
  end

  def citas
    @citas = Appointment.all
  end

  def consultorio
    @odontologo = Odontologo.find(params[:id])
    @consultorio = Consultorio.find(@odontologo.consultorios[0].id)
  end


end
