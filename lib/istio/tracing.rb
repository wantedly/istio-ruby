require "istio/tracing/context"
require "istio/tracing/header"
require "istio/tracing/http"
require "istio/tracing/rack"

begin
  require 'rails/railtie'
  rails_exists = true
rescue LoadError
  rails_exists = false
end

if rails_exists
  require 'istio/tracing/railtie'
end
