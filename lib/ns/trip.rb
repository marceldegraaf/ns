module Ns
  class Trip

    attr_accessor :from, :to, :departure, :arrival, :allow_hsl, :year_card

    def initialize(from, to, options = {})
      @from = Ns::Station.new(from)
      @to = Ns::Station.new(to)

      @departure = options.delete(:departure)
      @arrival   = options.delete(:arrival)
      @allow_hsl = options.delete(:allow_hsl) || false
      @year_card = options.delete(:year_card) || false
    end

    def formatted_time
      time.iso8601
    end

    def time
      [ departure, arrival ].compact.first
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

    private

    def arrival_present?
      !arrival.to_s.strip.empty?
    end

    def departure_present?
      !departure.to_s.strip.empty?
    end

  end
end
