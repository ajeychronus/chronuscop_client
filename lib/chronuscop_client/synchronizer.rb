require 'rubygems'
require 'mechanize'             # this is the http-client used.
require 'xmlsimple'             # necessary to parse xml response from the server.
require 'redis'                 # Redis client to interact with the redis key-value store.

module ChronuscopClient

  # This class handles synchronizing local and remote keys.
  class Synchronizer

    def start
      Thread.new { keep_in_sync }
    end

    # This method keeps the remote-keys and the local-keys synchronized.
    def keep_in_sync

      agent = Mechanize.new           # creating a new Mechanize agent object.
      redis_agent = Redis.new         # creating a redis client object.s

      for i in 1..30 do
        sleep(10)
        puts "Attempt Sync"

        # querying the page.
        page = agent.get("#{ChronuscopClient.configuration_object.chronuscop_server_address}/projects/#{ChronuscopClient.configuration_object.project_number}/translations.xml/?auth_token=#{ChronuscopClient.configuration_object.api_token}")

        # converting the returned xml page into a hash.
        words_hash = XmlSimple.xml_in(page.body)

        # collecting the translations array.
        all_translations = words_hash["translation"]

        # inserting all translations into the redis database.
        all_translations.each do |t|
          redis_agent.set "#{t["key"]}","#{t["value"]}"
        end

        puts "Finished synchronizing !!!"
      end
    end

  end
end


