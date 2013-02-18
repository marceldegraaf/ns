module Ns
  module Model

    def initialize(attributes = {})
      attributes.each do |k,v|
        send("#{k}=", v)
      end

      super if self.class.ancestors.include?(Ns::Api::Request::Base)
    end

  end
end
