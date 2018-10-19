module Client
  module Services
    module MockSources
      class Base
        attr_reader :client

        def initialize(client)
          @client = client
        end
      end
    end
  end
end
