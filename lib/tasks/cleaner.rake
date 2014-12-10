namespace :cleaner do
  desc "cleans out particular users"
  task remove_haiku: :environment do
    Haiku.where(author: "ThePostpoet").destroy_all;nil
    Haiku.where(author: "poetryninja").destroy_all;nil
    Haiku.where(author: "ProductPoet").destroy_all;nil
  end
end
