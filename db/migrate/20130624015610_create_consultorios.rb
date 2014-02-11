class CreateConsultorios < ActiveRecord::Migration
  def change
    create_table :consultorios do |t|
      t.string :nombre
      t.string :direccion
      t.string :ciudad
      t.string :zona
      t.string :lat
      t.string :long
      t.string :imagen1
      t.string :imagen2
      t.string :imagen3
      t.string :telefono
      t.integer :odontologo_id

      t.timestamps
    end
  end
end
