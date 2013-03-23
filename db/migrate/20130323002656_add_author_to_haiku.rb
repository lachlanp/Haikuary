class AddAuthorToHaiku < ActiveRecord::Migration
  def change
    add_column :haiku, :author, :string, default: "Anonymously"
    Haiku.reset_column_information
    Haiku.update_all author: "Anonymously"
  end
end
