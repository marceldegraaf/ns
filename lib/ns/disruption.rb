module Ns
  class Disruption
    include Ns::Model

    attr_accessor :route, :reason, :message, :advice, :period

  end
end
