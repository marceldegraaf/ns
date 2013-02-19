module Ns
  class Trip
    include Ns::Model

    attr_accessor :from, :to, :departure, :arrival, :allow_hsl, :year_card

    def from
      @from_station ||= Ns::Station.new(name: self.instance_variable_get("@from"))
    end

    def to
      @to_station ||= Ns::Station.new(name: self.instance_variable_get("@to"))
    end

    def allow_hsl
      self.instance_variable_get("@allow_hsl") || false
    end

    def year_card
      self.instance_variable_get("@year_card") || false
    end

    def formatted_time
      time.iso8601
    end

    def time
      [ departure, arrival ].compact.first || Time.now
    end

    def departure?
      !departure.nil? && !departure.to_s.strip.empty?
    end

    def valid?
      validate!
    rescue
      false
    end

    def validate!
      if !arrival_present? && !departure_present?
        raise "You should specify a departure or arrival time."
      end

      if (arrival_present? && arrival.class != Time) || (departure_present? && departure.class != Time)
        raise "Departure or arrival time should be an instance of Time"
      end

      true
    end

    def travel_options
      @travel_options ||= response.travel_options
    end

    private

    def arrival_present?
      !arrival.to_s.strip.empty?
    end

    def departure_present?
      !departure.to_s.strip.empty?
    end

    def travel_advice
      @travel_advice ||= Ns::Api::Request::TravelAdvice.new(trip: self)
    end

    def response
      @response ||= travel_advice.response
    end

  end
end
