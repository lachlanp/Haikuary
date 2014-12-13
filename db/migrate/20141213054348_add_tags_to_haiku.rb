class AddTagsToHaiku < ActiveRecord::Migration
  def change
    add_column :haiku, :tags, :text, array: true, index: true
  end
end
