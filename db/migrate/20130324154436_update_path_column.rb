class UpdatePathColumn < ActiveRecord::Migration
  def change
    Haiku.all.map{ |haiku| haiku.update_attribute(:file_path, "haiku_audio/#{haiku.id}.mp4")}
  end
end
