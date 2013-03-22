class CreateHaikus < ActiveRecord::Migration
  def change
    create_table :haikus do |t|

      t.timestamps
    end
  end
end
