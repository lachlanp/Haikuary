namespace :twitter do
  desc "Daily random tweet"
  task post_tweet: :environment do
    haiku = HaikuMaker.new.generate
    haiku.save
    Twitter.update(haiku.description)
  end
end
