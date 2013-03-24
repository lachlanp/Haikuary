class AddRouteToHaiku < ActiveRecord::Migration
  def up
    add_column :haiku, :file_path, :string
    Haiku.all.map{ |haiku| haiku.file_path = "haiku_audio/#{haiku.id}.aiff"; haiku.save}
  end
  def down
    remove_column :haiku, :file_path
  end
end
