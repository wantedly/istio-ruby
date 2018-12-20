# frozen_string_literal: true

require 'rails/railtie'

module YgreneIstioTracing
  module Tracing
    class Railtie < ::Rails::Railtie
      initializer 'ygrene_istio_tracing.tracing.rack_middleware' do |app|
        puts 'Tracing Loaded'
        app.middleware.use(::YgreneIstioTracing::Tracing::RackMiddleware)
      end
    end
  end
end
