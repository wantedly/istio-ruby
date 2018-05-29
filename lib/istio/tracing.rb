require "istio/tracing/context"
require "istio/tracing/header"
require "istio/tracing/http"
require "istio/tracing/rack"

begin
  require 'rails/railtie'
  require 'istio/tracing/railtie'
rescue LoadError
end
