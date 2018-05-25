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
        env.select{|k, v| k.start_with? 'HTTP_'}.map{|k, v| [k.gsub(/^HTTP_/, '').split('_').map(&:capitalize).join('-'), v]}.to_h
      end

    end

  end
end
