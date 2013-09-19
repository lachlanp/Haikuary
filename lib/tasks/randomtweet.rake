namespace :twitter do
  desc "Hourly random tweet"
  task post_tweet: :environment do
    haiku = HaikuMaker.new.generate
    if haiku.valid?
      Twitter.update(haiku.description)
    else
      Rake::Task["twitter:post_tweet"].invoke
    end
  end
end
