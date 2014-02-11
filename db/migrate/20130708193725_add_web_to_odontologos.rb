class AddWebToOdontologos < ActiveRecord::Migration
  def change
    add_column :odontologos, :web, :string
  end
end
