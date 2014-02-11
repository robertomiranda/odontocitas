class AddEstudioToOdontologo < ActiveRecord::Migration
  def change
    add_column :odontologos, :estudio, :string
    add_column :odontologos, :membrecia, :string
  end
end
