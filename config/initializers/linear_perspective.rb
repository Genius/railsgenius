Rails.configuration.to_prepare do
  LinearPerspective.configure do |config|
    config.caching = !!ENV['CACHE'] || ApplicationController.perform_caching

    server = ENV.fetch('BOXEN_MEMCACHED_URL', 'localhost:11211')
    config.cache = ActiveSupport::Cache::MemCacheStore.new(server).tap { |c| c.logger = Rails.logger }
  end
end
