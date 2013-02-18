module Ns
  module Api
    module Request
      class DisruptionCollection < Ns::Api::Request::Base
        include Ns::Model

        attr_accessor :station

        def self.base_uri
          'http://webservices.ns.nl/ns-api-storingen'
        end

        def self.response_class
          Ns::Api::Response::DisruptionCollection
        end

        private

        def query
          {
            station: station
          }
        end

      end
    end
  end
end
