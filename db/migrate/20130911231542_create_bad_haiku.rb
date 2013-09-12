class CreateBadHaiku < ActiveRecord::Migration
  def change
    create_table :bad_haiku do |t|
      t.string :author
      t.string :description
      t.integer :syllable_estimate
      t.boolean :converted

      t.timestamps
    end
  end
end
