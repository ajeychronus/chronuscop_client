require 'chronuscop_client/configuration'

module ChronuscopClient

  # defining necessary objects which will be used.
  class << self

    # The configuration object stores all the configuration information.
    attr_accessor :configuration_object

    # The synchronizer object.
    attr_accessor :synchronizer_object

  end

  def self.test
    puts "Works"
  end
end

