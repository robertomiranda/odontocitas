class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :odontologo_id
      t.integer :paciente_id
      t.string :hora
      t.string :dia
      t.string :mes
      t.string :ano

      t.timestamps
    end
  end
end
