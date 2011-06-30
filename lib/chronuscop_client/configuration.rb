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

    # The project number.(in the chronuscop server.)
    attr_accessor :project_number

    # The chronuscop server address.
    attr_accessor :chronuscop_server_address

    # The rails environment.
    attr_accessor :rails_environment

    # The rails root directory.
    attr_accessor :rails_root_dir

    # setting configuration values.
    def set_all_values
      self.redis_db_number = 0
      self.redis_server_port = 6379
      self.yaml_file_location = "#{self.rails_root_dir}/config/locales/en.yml"
      self.chronuscop_server_address = "http://localhost:3000"
    end

  end

end
