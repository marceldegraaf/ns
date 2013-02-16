module Ns
  module Request
    class TravelAdvice < Ns::Request::Base

      attr_accessor :trip

      def self.base_uri
        'http://webservices.ns.nl/ns-api-treinplanner'
      end

      def initialize(trip)
        @trip = trip
      end

      private

      def query
        {
          fromStation: trip.from.name,
          toStation: trip.to.name,
          dateTime: trip.formatted_time,
          departure: trip.departure?,
          hslAllowed: trip.allow_hsl,
          yearCard: trip.year_card
        }
      end

    end
  end
end
