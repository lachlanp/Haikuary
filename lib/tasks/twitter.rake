namespace :import do
  desc "import tweets with haiku hashtag"
  task twitter_haiku: :environment do
    tweets = TwitterImporter.new.latest_tweets.reverse
    Haiku.transaction do
      tweets.each(&:save_haiku)
    end
  end

  desc "import tweets with haikudetat hashtag"
  task twitter_haikudetat: :environment do
    tweets = TwitterImporter.new.latest_coups.reverse
    Haiku.transaction do
      tweets.each(&:save_haiku)
    end
  end
end
