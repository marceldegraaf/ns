module Ns
  module Request
    class Base

      attr_reader :response

      def initialize
        HTTPI.log = false
      end

      def perform
        @response = HTTPI.get(url_for_request)
      end

      private

      def url_for_request
        http_request_with_query.url
      end

      def http_request_with_query
        http_request.query = query
        http_request
      end

      def http_request
        @http_request ||= HTTPI::Request.new(self.class.base_uri)
      end

      def self.base_uri; raise "Implement me in a subclass"; end
      def query; raise "Implement me in a subclass"; end

    end
  end
end
