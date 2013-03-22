class AddStuffToHaikuTable < ActiveRecord::Migration
  def change
    add_column :haikus, :description, :string
  end
end
