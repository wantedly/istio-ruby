# frozen_string_literal: true

module Istio
  module Tracing
    class RackMiddleware

      def initialize(app)
        @app = app
      end

      def call(env)
        Context.build_current(extract_http_headers(env))
        @app.call(env)
      ensure
        Context.remove_current
      end

      def extract_http_headers(env)
        env.select { |k, _v| PROPAGATION_HEADERS.include?(k.downcase) }
      end
    end
  end
end
