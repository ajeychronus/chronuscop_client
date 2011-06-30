require 'chronuscop_client'
require 'rails'

module ChronuscopClient
  # Connects to integration points for Rails 3 applications
  class Railtie < ::Rails::Railtie
    initializer :initialize_chronuscop_rails, :after => :before_initialize do |app|

      # to be removed.
      puts "Initializing the chronuscop client."

      # creating a new configuration object.
      ChronuscopClient.configuration_object = ChronuscopClient::Configuration.new

      # setting the root directory.
      ChronuscopClient.configuration_object.rails_root_dir = ::Rails.root

      # setting the rails environment.
      ChronuscopClient.configuration_object.rails_environment = ::Rails.env

      # reading redis database number from the YAML file (app/config/chronuscop.yml)
      ChronuscopClient.configuration_object.load_yaml_configuration

      # TODO. A better method should be employed.
      ChronuscopClient.configuration_object.chronuscop_server_address = "http://localhost:3000"

      # creating a new synchronizer object.
      ChronuscopClient.synchronizer_object = ChronuscopClient::Synchronizer.new



    end

    rake_tasks do
      load "tasks/chronuscop_client_tasks.rake"
    end
  end
end

