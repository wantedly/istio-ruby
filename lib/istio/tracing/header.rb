# frozen_string_literal: true

module Istio
  module Tracing
    PROPAGATION_HEADERS = %w[
      x-request-id
      x-b3-traceid
      x-b3-spanid
      x-b3-parentspanid
      x-b3-sampled
      x-b3-flags
      x-ot-span-context
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
