class HaikuTagJob
  include Sidekiq::Worker

  def perform(id)
    find_haiku = haiku(id)
    tag_haiku(find_haiku)
  end

private

  def haiku(id)
    Haiku.find(id)
  end

  def tag_haiku(h)
    HaikuTagger.new(h, true).tag_haiku
  end
end
