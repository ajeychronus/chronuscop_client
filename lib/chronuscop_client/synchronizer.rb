require 'rubygems'
require 'mechanize'             # this is the http-client used.
require 'xmlsimple'             # necessary to parse xml response from the server.
require 'redis'                 # Redis client to interact with the redis key-value store.

module ChronuscopClient

  # This class handles synchronizing local and remote keys.
  class Synchronizer
    attr_accessor :run_synchronizer

    def initialize(redis_db_number = 0)
      @mechanize_agent = Mechanize.new # mechanize client.
      @redis_agent = Redis.new(:db => redis_db_number) # redis client.
      @run_synchronizer = true
    end

    def start
      Thread.new { keep_in_sync }
    end

    # This method keeps the remote-keys and the local-keys synchronized.
    # This method should be called only after initializing the configuration
    # object as it uses those configuration values.
    def keep_in_sync

      while(@run_synchronizer)
        sleep(ChronuscopClient.configuration_object.sync_time_interval)
        puts "Attempt Sync"

        # querying the page.
        page = @mechanize_agent.get("#{ChronuscopClient.configuration_object.chronuscop_server_address}/projects/#{ChronuscopClient.configuration_object.project_number}/translations.xml/?auth_token=#{ChronuscopClient.configuration_object.api_token}")

        # converting the returned xml page into a hash.
        words_hash = XmlSimple.xml_in(page.body)

        # collecting the translations array.
        all_translations = words_hash["translation"]

        # inserting all translations into the redis database.
        all_translations.each do |t|
          @redis_agent.set "#{t["key"]}","#{t["value"]}"
        end

        puts "Finished synchronizing !!!"
      end
    end

  end
end


