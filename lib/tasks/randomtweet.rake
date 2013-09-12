namespace :twitter do
  desc "Hourly random tweet"
  task post_tweet: :environment do
    haiku = HaikuMaker.new.generate
    Twitter.update(haiku.description)
  end
end
