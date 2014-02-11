class CreateSpecialities < ActiveRecord::Migration
  def change
    create_table :specialities do |t|
      t.integer :id_odontologo
      t.string :especialidad

      t.timestamps
    end
  end
end
