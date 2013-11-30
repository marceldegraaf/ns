require 'ns/api/request/base'

module Ns
  module Api
    module Request
      class DepartureCollection < Ns::Api::Request::Base
        include Ns::Model
        attr_accessor :departure_collection

        def self.base_uri
          'http://webservices.ns.nl/ns-api-avt'
        end

        def self.response_class
          Ns::Api::Response::DepartureCollection
        end

        private

        def query
          {
            station:   departure_collection.station
          }
        end

      end
    end
  end
end
