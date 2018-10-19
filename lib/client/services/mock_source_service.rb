require_relative 'mock_sources/base'
require_relative 'mock_sources/sources'

module Client
  module Services
    class MockSourceService
      attr_reader :client

      def initialize(host:, logger: nil)
        @client = Client::Base.new(host: host, logger: logger)
      end

      def sources
        @sources ||= MockSources::Sources.new(client)
      end
    end
  end
end
