module Ns
  module Api
    module Request
      class Base

        attr_reader :response, :parsed_response

        def initialize(*args)
          HTTPI.log = false
        end

        def response
          self.class.response_class.new(parsed_response)
        end

        private

        def url_for_request
          http_request_with_query
        end

        def http_request_with_query
          http_request.query = query
          http_request
        end

        def http_request
          @http_request ||= HTTPI::Request.new(self.class.base_uri)
        end

        def parsed_response
          @parsed_response ||= response_parser.parsed_response
        end

        def response_parser
          @response_parser ||= Ns::Api::Response::Parser.new(response_body)
        end

        def response_body
          @response_body ||= plain_text_response.body
          #@response_body ||= File.read(File.join($ROOT, 'spec/fixtures/ns_travel_advice_response.xml'))
        end

        def plain_text_response
          @plain_text_response ||= HTTPI.get(url_for_request)
        end

        def self.base_uri; raise "Implement me in a subclass"; end
        def self.response_class; raise "Implement me in a subclass"; end
        def query; raise "Implement me in a subclass"; end

      end
    end
  end
end