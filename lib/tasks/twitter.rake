namespace :import do
  desc "import tweets with haiku hashtag"
  task twitter_haiku: :environment do
    tweets = TwitterImporter.new.latest_tweets.reverse
    tweets.each(&:save_haiku)
  end
end

namespace :import do
  desc "import tweets with haikudetat hashtag"
  task twitter_haikudetat: :environment do
    tweets = TwitterImporter.new.latest_coups.reverse
    tweets.each(&:save_haiku)
  end
end
