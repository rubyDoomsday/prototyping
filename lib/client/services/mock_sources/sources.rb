module Client
  module Services
    module MockSources
      class Sources < Base
        def all(options = {})
          client.get("/sources", options)
        end

        def find(id, options = {})
          client.get("/sources/#{id}", options)
        end
      end
    end
  end
end
