require 'rubygems'
require 'mechanize'             # this is the http-client used.
require 'xmlsimple'             # necessary to parse xml response from the server.
require 'redis'                 # Redis client to interact with the redis key-value store.

# The configuration class which stores all the configurable options for the chronuscop client.
module ChronuscopClient

  class Configuration
    # The redis database number.(Redis doesn't support database names)
    attr_accessor :redis_db_number

    # The redis server port number.
    attr_accessor :redis_server_port

    # The yaml file location in the rails app.
    attr_accessor :yaml_file_location

    # The api token.
    attr_accessor :api_token

    # The chronuscop server address.
    attr_accessor :chronuscop_server_address

    # The rails environment.
    attr_accessor :rails_environment

    # The rails root directory.


    def initialize              # the constructor
    end


  end

end
