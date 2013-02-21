module Ns
  class Disruption
    include Ns::Model

    attr_accessor :route, :reason, :message, :advice, :period

    def advice
      stripped(@advice)
    end

    def message
      stripped(@message)
    end

    def reason
      stripped(@reason)
    end

    private

    def stripped(string)
      string.strip.gsub(/\s+/, ' ')
    end

  end
end
