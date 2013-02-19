module Ns
  module Api
    module Response
      class Parser
        include Ns::Model

        attr_accessor :response_text

        def parsed_response
          @parsed_response ||= parser.parse(response_text)
        end

        private

        def parser
          @parser ||= Nori.new
        end

      end
    end
  end
end
