class RemoveVetoFromHaiku < ActiveRecord::Migration
  def change
    remove_column :haiku, :veto, :boolean
  end
end
