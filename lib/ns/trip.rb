module Ns
  class Trip

    include Ns::Request

    attr_accessor :from, :to, :departure, :arrival, :allow_hsl, :year_card

    def initialize(from, to, options = {})
      @from = Ns::Station.new(from)
      @to = Ns::Station.new(to)

      @departure = options.delete(:departure)
      @arrival   = options.delete(:arrival)
      @allow_hsl = options.delete(:allow_hsl) || false
      @year_card = options.delete(:year_card) || false
    end

    def valid?
      validate!
    rescue
      false
    end

    def validate!
      if arrival.to_s.strip.empty? && departure.to_s.strip.empty?
        raise "You should specify a departure or arrival time."
      end

      true
    end

  end
end
