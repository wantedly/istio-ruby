require 'net/http'

module Istio
  module Tracing

    module NetHTTPHook

      def request(req, *args, &block)
        return super unless Context.exists_current?
        headers = Context.current.headers
        PROPAGETION_HEADERS.each do |h|
          req[h] = headers[h] if headers[h].present?
        end
        super
      end

    end

  end
end

class Net::HTTP
  prepend Istio::Tracing::NetHTTPHook
end
