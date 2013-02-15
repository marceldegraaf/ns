module Ns
  module Request

    def self.included(base)
      HTTPI.log = false
    end

  end
end
