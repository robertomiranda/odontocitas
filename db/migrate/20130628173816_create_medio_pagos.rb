class CreateMedioPagos < ActiveRecord::Migration
  def change
    create_table :medio_pagos do |t|
      t.integer :id_odontologo
      t.string :medio_pago

      t.timestamps
    end
  end
end
