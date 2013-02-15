require "ns/version"

module Ns
  class << self

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Ns::Configuration.new
    end

  end
end
