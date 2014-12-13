class TaggingWorker
  include Sidekiq::Worker

  def perform
    ids.each do |slice_ids|
      slice_ids.each do |id|
        HaikuTagJob.perform_async(id)
      end
    end
  end

private

  def ids
    Haiku.where(tags: nil).pluck(:id).each_slice(1000)
  end
end
