# requiring gem dependencies.
require 'rubygems'
require 'yaml'

# requiring other files.
require 'chronuscop_client/synchronizer'
require 'chronuscop_client/railtie' if defined?(Rails)

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
      yaml_config = YAML.load_file("#{@rails_root_dir}/config/chronuscop.yml")
      @redis_db_number = yaml_config[@rails_environment]['redis_db_number']
      @redis_server_port = yaml_config[@rails_environment]['redis_server_port']
      @project_number = yaml_config[@rails_environment]['project_number']
      @api_token = yaml_config[@rails_environment]['api_token']
      @chronuscop_server_address = yaml_config[@rails_environment]['chronuscop_server_address']
    end


  end
end
