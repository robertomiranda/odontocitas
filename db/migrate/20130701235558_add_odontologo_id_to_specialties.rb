class AddOdontologoIdToSpecialties < ActiveRecord::Migration
  def change
    add_column :specialities, :odontologo_id, :string
    remove_column :specialities, :id_odontologo, :string
  end
end
