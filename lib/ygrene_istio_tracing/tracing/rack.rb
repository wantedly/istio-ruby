# frozen_string_literal: true

module YgreneIstioTracing
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
        env.select do |k, _v|
          header = k.upcase.gsub(/^HTTP_/, '').tr('_', '-')
          PROPAGATION_HEADERS.include?(header)
        end
      end
    end
  end
end
