class AddComentariosToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :motivo, :string
    add_column :appointments, :modo_pago , :string
    add_column :appointments, :medio_pago, :string
    add_column :appointments, :tipo_consulta, :string
    add_column :appointments, :comentarios, :text
  end
end
