class CreateOdontologos < ActiveRecord::Migration
  def change
    create_table :odontologos do |t|
      t.string :nombre
      t.string :apellido
      t.string :correo
      t.string :especialidad
      t.string :clave
      t.string :celular
      t.string :telefono
      t.string :direccion
      t.string :usuario

      t.timestamps
    end
  end
end
