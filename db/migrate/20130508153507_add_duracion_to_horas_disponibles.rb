class AddDuracionToHorasDisponibles < ActiveRecord::Migration
  def change
  	create_table :horas_disponibles do |t|
      t.integer :odontologo_id
      t.string :hora
      t.string :dia
      t.string :mes
      t.string :ano
      t.string :duracion

      t.timestamps
    end
  end
end
