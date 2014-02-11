class AddEstadoToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :estado, :string
  end
end
