class AddOdontologoIdToPrepagadas < ActiveRecord::Migration
  def change
    add_column :prepagadas, :odontologo_id, :integer
    remove_column :prepagadas, :id_odontologo, :string

    add_column :consulta, :odontologo_id, :integer
    remove_column :consulta, :id_odontologo, :string

    add_column :medio_pagos, :odontologo_id, :integer
    remove_column :medio_pagos, :id_odontologo, :string
  end
end
