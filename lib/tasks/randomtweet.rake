namespace :twitter do
  desc "Hourly random tweet"
  task post_tweet: :environment do
    haiku = HaikuMaker::Base.new.result
    if haiku.save
  	  Twitter::Session.new.client.update(haiku.description)
    else
      Rake::Task["twitter:post_tweet"].invoke
    end
  end
end
