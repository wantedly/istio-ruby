module Istio
  module Tracing

    class NotSetError < ::StandardError
      def initialize
        super('Context is not set for this thread')
      end
    end

    class Context
      VAR_NAME = :_istio_tracing_context_

      class << self

        def current
          Thread.current.thread_variable_get(VAR_NAME) || raise(NotSetError)
        end

        def with_given_context(ctx)
          Thread.current.thread_variable_set(VAR_NAME, ctx)
          yield
        ensure
          remove_current
        end

        def exists_current?
          !!Thread.current.thread_variable_get(VAR_NAME)
        end

        def build_current(headers)
          Thread.current.thread_variable_set(VAR_NAME, Context.new(headers))
        end

        def remove_current
          Thread.current.thread_variable_set(VAR_NAME, nil)
        end

      end

      attr_reader :headers

      def initialize(headers)
        @headers = headers
      end

    end

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
