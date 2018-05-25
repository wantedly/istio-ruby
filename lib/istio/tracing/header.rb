module Istio
  module Tracing

    PROPAGETION_HEADERS = %w[
      X-Request-Id
      X-B3-Traceid
      X-B3-Spanid
      X-B3-Parentspanid
      X-B3-Sampled
      X-B3-Flags
      X-Ot-Span-Context
    ]

  end
end
