module Ns
  class DisruptionCollection
    include Ns::Model

    attr_accessor :station

    def planned_disruptions
      @planned_disruptions ||= response.planned_disruptions
    end

    def unplanned_disruptions
      @planned_disruptions ||= response.unplanned_disruptions
    end

    private

    def response
      @response ||= disruption_collection.response
    end

    def disruption_collection
      @disruption_collection ||= Ns::Api::Request::DisruptionCollection.new(station: station)
    end

  end
end
