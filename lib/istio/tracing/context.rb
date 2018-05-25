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

  end
end
