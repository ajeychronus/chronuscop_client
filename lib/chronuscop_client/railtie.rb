require 'chronuscop_client'
require 'rails'

module ChronuscopClient
  # Connects to integration points for Rails 3 applications
  class Railtie < ::Rails::Railtie
    initializer :initialize_chronuscop_rails, :after => :before_initialize do |app|
      puts ::Rails.env
      puts app.env
    end

    rake_tasks do
      load "tasks/chronuscop_client_tasks.rake"
    end
  end
end

