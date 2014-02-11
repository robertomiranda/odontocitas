class AddGeneroToOdontologos < ActiveRecord::Migration
  def change
    add_column :odontologos, :genero, :string
  end
end
