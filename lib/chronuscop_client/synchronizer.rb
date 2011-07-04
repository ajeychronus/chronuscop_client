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

    # Function to write the last update time to a temporary file.
    def write_last_update(last_update_at)
      # Check for the presence of the tmp directory.
      if(! File::directory?("tmp")) then
        Dir.mkdir("tmp")
      end

      f = File.new("tmp/chronuscop.tmp","w")
      f.printf("%d",last_update_at.to_i)
      f.close()
    end


    def get_last_update_at
      # Check for the presence of the file.
      if(! File::exists?("tmp/chronuscop.tmp")) then
        return 0
      else
        last_update_at = File.read("tmp/chronuscop.tmp").to_i
        return last_update_at
      end
    end

    def start
      Thread.new { keep_in_sync }
    end


    def keep_in_sync
      while(@run_synchronizer)

        # Sleep for 'x' seconds. 'x' is specified in the config file.
        sleep(ChronuscopClient.configuration_object.sync_time_interval)

        # Calling the sync_it_now function.
        sync_it_now
      end
    end

    # This method keeps the remote-keys and the local-keys synchronized.
    # This method should be called only after initializing the configuration
    # object as it uses those configuration values.
    def sync_it_now
      puts "Attempt Sync"

      # Getting the last sync value.
      last_update_at = get_last_update_at

      # querying the page.
      page = @mechanize_agent.get("#{ChronuscopClient.configuration_object.chronuscop_server_address}/projects/#{ChronuscopClient.configuration_object.project_number}/translations.xml/?auth_token=#{ChronuscopClient.configuration_object.api_token}&last_update_at=#{last_update_at}")

      # converting the returned xml page into a hash.
      words_hash = XmlSimple.xml_in(page.body)

      # catching the case when no-translations are returned.
      if(!words_hash) then
        puts "Nothing new added."
        return
      end

      # collecting the translations array.
      all_translations = words_hash["translation"]

      # catching the case when no-translations are returned.
      if(!all_translations) then
        puts "Nothing new added."
        return
      end


      all_translations.each do |t|

        # Inserting into the redis store.
        @redis_agent.set "#{t["key"]}","#{t["value"]}"

        # Updating the value last_update_at
        if(t.updated_at > last_update_at) then
          last_update_at = t.updated_at
        end

      end
      puts "Writing the last_update_value of #{last_update_value}"
      # Writing the value of last_update_at to the file.
      write_last_update(last_update_at)


      puts "Finished synchronizing !!!"
    end


  end
end


