class AddYoutubeToOdontologos < ActiveRecord::Migration
  def change
    add_column :odontologos, :youtube, :string
  end
end
