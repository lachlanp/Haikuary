
namespace :import do
  desc "import tweets with haikudetat hashtag"
  task twitter_haikudetat: :environment do
    tweets = TwitterImporter.latest_tweets
    tweets.each {|t| t.save_haiku }
    # tweets.each {|t| puts t.to_s }
  end
end
