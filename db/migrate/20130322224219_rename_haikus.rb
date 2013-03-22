class RenameHaikus < ActiveRecord::Migration
  def change
    rename_table :haikus, :haiku
  end
end
