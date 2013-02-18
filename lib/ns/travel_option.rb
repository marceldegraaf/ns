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
      (planned_arrival - planned_departure).to_i
    end

    def actual_duration
      (actual_arrival - actual_departure).to_i
    end

  end
end
