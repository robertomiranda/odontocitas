class CreatePrepagadas < ActiveRecord::Migration
  def change
    create_table :prepagadas do |t|
      t.integer :id_odontologo
      t.string :prepagada

      t.timestamps
    end
  end
end
