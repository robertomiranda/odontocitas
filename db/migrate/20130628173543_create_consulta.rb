class CreateConsulta < ActiveRecord::Migration
  def change
    create_table :consulta do |t|
      t.integer :id_odontologo
      t.string :consulta_aceptada

      t.timestamps
    end
  end
end
