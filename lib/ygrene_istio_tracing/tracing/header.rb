# frozen_string_literal: true

module YgreneIstioTracing
  module Tracing
    PROPAGATION_HEADERS = %w[
      X-REQUEST-ID
      X-B3-TRACEID
      X-B3-SPANID
      X-B3-PARENTSPANID
      X-B3-SAMPLED
      X-B3-FLAGS
      X-OT-SPAN-CONTEXT
    ].freeze
  end
end
