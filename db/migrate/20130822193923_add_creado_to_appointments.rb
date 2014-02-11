class AddCreadoToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :creado_por, :string
  end
end
