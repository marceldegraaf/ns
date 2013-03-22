require 'ns/api/request/base'

module Ns
  module Api
    module Request
      class DisruptionCollection < Ns::Api::Request::Base
        include Ns::Model

        attr_accessor :disruption_collection

        def self.base_uri
          'http://webservices.ns.nl/ns-api-storingen'
        end

        def self.response_class
          Ns::Api::Response::DisruptionCollection
        end

        private

        def query
          {
            station:   disruption_collection.station,
            actual:    disruption_collection.actual,
            unplanned: disruption_collection.include_planned
          }
        end

      end
    end
  end
end
