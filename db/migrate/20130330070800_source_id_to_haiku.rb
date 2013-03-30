class SourceIdToHaiku < ActiveRecord::Migration
  def change
    add_column :haiku, :source_id, :string
  end
end
