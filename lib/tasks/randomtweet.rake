namespace :twitter do
  desc "Hourly random tweet"
  task post_tweet: :environment do
    haiku = HaikuMaker::Base.new.result
    if haiku.valid? && haiku.is_new_line_formatted?
	  Twitter::Session.new.client.update(haiku.description)
    else
      Rake::Task["twitter:post_tweet"].invoke
    end
  end
end
