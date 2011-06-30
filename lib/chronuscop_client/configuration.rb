# requiring gem dependencies.
require 'rubygems'
require 'mechanize'             # this is the http-client used.
require 'xmlsimple'             # necessary to parse xml response from the server.
require 'redis'                 # Redis client to interact with the redis key-value store.
requier 'yaml'

# requiring other files.
require 'chronuscop_client/synchronizer'

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

    # rails root directory must be set before calling this.
    def load_yaml_configuration
      YAML_CONFIG = YAML.load_file("#{@rails_root_dir}/app/config/chronuscop.yml")
      @redis_db_number = YAML_CONFIG[@rails_environment]['redis_db_number']
      @redis_server_port = YAML_CONFIG[@rails_environment]['redis_server_port']
      @project_number = YAML_CONFIG[@rails_environment]['project_number']
      @api_token = YAML_CONFIG[@rails_environment]['api_token']
    end


  end
end
