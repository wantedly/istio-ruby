# frozen_string_literal: true

require 'rails/railtie'

module Istio
  module Tracing
    class Railtie < ::Rails::Railtie
      initializer 'istio.tracing.rack_middleware' do |app|
        puts 'Tracing Loaded'
        app.middleware.use(::Istio::Tracing::RackMiddleware)
      end
    end
  end
end
