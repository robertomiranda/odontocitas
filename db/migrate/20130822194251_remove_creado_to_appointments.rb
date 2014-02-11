class RemoveCreadoToAppointments < ActiveRecord::Migration
  def up
    remove_column :appointments, :creado_por
  end

  def down
    add_column :appointments, :creado_por, :string
  end
end
