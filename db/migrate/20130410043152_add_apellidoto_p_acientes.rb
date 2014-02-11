class AddApellidotoPAcientes < ActiveRecord::Migration
  def change
    add_column :pacientes, :apellido, :string
    add_column :pacientes, :genero, :string
    add_column :pacientes, :como_se_entero, :string
  end
end
