module Ns
  class DepartureCollection
    include Ns::Model

    attr_accessor :station

    def departures
      @departures ||= response.departures
    end

    private

    def response
      @response ||= departure_collection.response
    end

    def departure_collection
      @departure_collection ||= Ns::Api::Request::DepartureCollection.new(departure_collection: self)
    end

  end
end
