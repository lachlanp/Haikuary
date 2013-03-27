class AddUrlToHaiku < ActiveRecord::Migration
  def change
    add_column :haiku, :haiku_url_cache, :string
    Haiku.all.each do |haiku|
      haiku.haiku_url_cache = `curl "http://tts-api.com/tts.mp3?q=#{haiku.description.gsub("\n"," ").gsub("\r"," ").gsub(";",":").split().join("+")}&return_url=1"`
      haiku.save
    end
  end
end
