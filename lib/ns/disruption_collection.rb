module Ns
  class DisruptionCollection
    include Ns::Model

    attr_accessor :station, :actual, :include_planned

    def planned_disruptions
      @planned_disruptions ||= response.planned_disruptions
    end

    def unplanned_disruptions
      @planned_disruptions ||= response.unplanned_disruptions
    end

    #
    # If actual=true, the unplanned disruptions are returned, as well
    # as the planned disruptions (due to maintenance) that will occur
    # within two hours of the request.
    #
    def actual
      self.instance_variable_get("@actual") || true
    end

    #
    # For some reason NS has decided that passing "unplanned=true"
    # will return the *planned* disruptions. We pass a default value
    # of unplanned=false so planned disruptions don't show up by
    # default.
    #
    def include_planned
      self.instance_variable_get("@include_planned") || false
    end

    private

    def response
      @response ||= disruption_collection.response
    end

    def disruption_collection
      @disruption_collection ||= Ns::Api::Request::DisruptionCollection.new(disruption_collection: self)
    end

  end
end
