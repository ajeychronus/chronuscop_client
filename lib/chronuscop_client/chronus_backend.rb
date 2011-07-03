require 'rubygems'
require 'redis'

module ChronuscopClient

  # This backend will be used for translations.
  class ChronusBackend

    def initialize(redis_db_number = 0)
      @redis_agent = Redis.new(:db => redis_db_number)
    end


    def [](key)
      @redis_agent[key]
    end

    def []=(key,value)
      @redis_agent[key] = value
    end

    def keys
      @redis_agent.keys
    end
  end
end
