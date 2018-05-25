require "tracing/context"
require "tracing/header"
require "tracing/http"
require "tracing/rack"

begin
  require 'rails/railtie'
  rails_exists = true
rescue LoadError
  rails_exists = false
end

if rails_exists
  require 'istio/tracing/railtie'
end
