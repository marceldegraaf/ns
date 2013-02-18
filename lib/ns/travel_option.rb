module Ns
  class TravelOption

    attr_accessor :planned_departure, :actual_departure,
                  :planned_arrival, :actual_arrival,
                  :changes

    def initialize(attributes = {})
      attributes.each do |k,v|
        self.send("#{k}=", v)
      end
    end

    def planned_duration
      duration(planned_arrival, planned_departure)
    end

    def actual_duration
      duration(actual_arrival, actual_departure)
    end

    def delay
      duration(actual_departure, planned_departure)
    end

    private

    def duration(latest, first)
      ((latest - first) * 24 * 60 * 60).to_i
    end

  end
end
