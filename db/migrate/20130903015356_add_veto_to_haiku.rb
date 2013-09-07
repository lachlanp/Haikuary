class AddVetoToHaiku < ActiveRecord::Migration
  def change
    add_column :haiku, :veto, :boolean
  end
end
