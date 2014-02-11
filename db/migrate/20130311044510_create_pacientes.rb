class CreatePacientes < ActiveRecord::Migration
  def change
    create_table :pacientes do |t|
      t.string :nombre
      t.string :correo
      t.string :clave
      t.string :celular
      t.string :telefono
      t.string :usuario

      t.timestamps
    end
  end
end
