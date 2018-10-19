Dir[File.dirname(__FILE__) + '/services/*.rb'].each { |file| require file }

module Client
  module Services
  end
end
