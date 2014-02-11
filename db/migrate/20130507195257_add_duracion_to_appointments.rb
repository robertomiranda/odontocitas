class AddDuracionToAppointments < ActiveRecord::Migration
  def change
  	add_column :appointments, :duracion, :string
  end
end
