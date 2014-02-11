class AddImageToOdontologos < ActiveRecord::Migration
  def change
  	 add_column :odontologos, :image, :string
  	 add_column :odontologos, :fecha_nacimiento, :string
  	 add_column :odontologos, :perfil, :text
  	 add_column :odontologos, :facebook, :text
  	 add_column :odontologos, :twitter, :text
  	 add_column :odontologos, :linkedin, :text
  end
end
