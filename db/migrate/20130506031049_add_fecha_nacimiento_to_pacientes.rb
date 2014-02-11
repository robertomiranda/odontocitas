class AddFechaNacimientoToPacientes < ActiveRecord::Migration
  def change
  	add_column :pacientes, :fecha_nacimiento, :string
  end
end
