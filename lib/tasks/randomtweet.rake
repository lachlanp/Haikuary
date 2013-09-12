namespace :twitter do
  desc "Hourly random tweet"
  task post_tweet: :environment do
    haiku = HaikuMaker.new.generate
    bad = BadHaiku.create(description: @haiku.description, author: @haiku.author, syllable_estimate: SyllableCounter::Count.new.get_syllables(@haiku.description) ) unless haiku.save
    Twitter.update(haiku.description)
  end
end
