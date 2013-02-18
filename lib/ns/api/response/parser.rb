module Ns
  module Api
    module Response
      class Parser

        attr_reader :response_text

        def initialize(response_text)
          @response_text = response_text
        end

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
