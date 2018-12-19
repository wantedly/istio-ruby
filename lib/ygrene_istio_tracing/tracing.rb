# frozen_string_literal: true

require 'ygrene_istio_tracing/tracing/context'
require 'ygrene_istio_tracing/tracing/header'
require 'ygrene_istio_tracing/tracing/http'
require 'ygrene_istio_tracing/tracing/rack'

begin
  require 'rails/railtie'
  require 'ygrene_istio_tracing/tracing/railtie'
rescue LoadError
end
