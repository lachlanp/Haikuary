class DropFilePathAndUrlFromHaiku < ActiveRecord::Migration
  def change
    remove_column :haiku, :file_path
    remove_column :haiku, :haiku_url_cache
  end
end
