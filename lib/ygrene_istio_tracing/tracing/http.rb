# frozen_string_literal: true

require 'net/http'
require 'typhoeus'

module YgreneIstioTracing
  module NetHttp
    module ClassInterceptor
      def new(*options)
        o = super(*options)
        o
      end
    end
    module InstanceInterceptor
      def initialize(*options)
        super(*options)
      end

      def request(req, *args, &block)
        return super unless Context.exists_current?

        headers = YgreneIstioTracing::Tracing::Context.current.headers
        YgreneIstioTracing::Tracing::PROPAGATION_HEADERS.each do |h|
          req[h] = headers[h] if headers[h].present?
        end
        super
      end
    end
  end
end

::Net::HTTP.singleton_class.prepend YgreneIstioTracing::NetHttp::ClassInterceptor
::Net::HTTP.prepend YgreneIstioTracing::NetHttp::InstanceInterceptor

module Typhoeus
  Typhoeus.before do |req|
    return req unless YgreneIstioTracing::Tracing::Context.exists_current?

    headers = YgreneIstioTracing::Tracing::Context.current.headers
    YgreneIstioTracing::Tracing::PROPAGATION_HEADERS.each do |h|
      req.options[:headers][h] = headers[h] unless headers[h]&.nil?
    end
    req
  end
end
