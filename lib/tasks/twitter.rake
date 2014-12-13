namespace :import do
  desc "import tweets with haiku hashtag"
  task twitter_haiku: :environment do
    tweets = TwitterImporter.new.latest_tweets.reverse
    tweets.each {|t| t.save_haiku }
    tweets.each {|t| puts t.to_s }
  end
end

namespace :import do
  desc "import tweets with haikudetat hashtag"
  task twitter_haikudetat: :environment do
    tweets = TwitterImporter.new.latest_coups.reverse
    tweets.each {|t| t.save_haiku }
    tweets.each {|t| puts t.to_s }
  end
end
