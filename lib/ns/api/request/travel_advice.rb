module Ns
  module Api
    module Request
      class TravelAdvice < Ns::Api::Request::Base
        include Ns::Model

        attr_accessor :trip

        def self.base_uri
          'http://webservices.ns.nl/ns-api-treinplanner'
        end

        def self.response_class
          Ns::Api::Response::TravelAdvice
        end

        private

        def query
          {
            fromStation: trip.from.name,
            toStation:   trip.to.name,
            dateTime:    trip.formatted_time,
            departure:   trip.departure?,
            hslAllowed:  trip.allow_hsl,
            yearCard:    trip.year_card
          }
        end

      end
    end
  end
end
