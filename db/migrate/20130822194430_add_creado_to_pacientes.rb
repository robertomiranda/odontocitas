class AddCreadoToPacientes < ActiveRecord::Migration
  def change
    add_column :pacientes, :creado_por, :string
  end
end
