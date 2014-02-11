
every 15.minutes do
	runner "Appointment.cambiar_estado_asistida" , :environment => 'development'
end