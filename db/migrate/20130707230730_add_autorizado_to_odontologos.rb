class AddAutorizadoToOdontologos < ActiveRecord::Migration
  def change
    add_column :odontologos, :autorizado, :string
  end
end
