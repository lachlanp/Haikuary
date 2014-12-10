class DropTableBadHaiku < ActiveRecord::Migration
  def change
    drop_table :bad_haiku
  end
end
