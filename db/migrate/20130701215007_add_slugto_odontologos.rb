class AddSlugtoOdontologos < ActiveRecord::Migration
  def change
    add_column :odontologos, :slug, :string
  end
end
