# frozen_string_literal: true

require 'net/http'
require 'typhoeus'

module Istio
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

        headers = Context.current.headers
        PROPAGATION_HEADERS.each do |h|
          req[h] = headers[h] if headers[h].present?
        end
        super
      end
    end
  end
end

::Net::HTTP.singleton_class.prepend Istio::NetHttp::ClassInterceptor
::Net::HTTP.prepend Istio::NetHttp::InstanceInterceptor

module Typhoeus
  Typhoeus.before do |req|
    return req unless Istio::Tracing::Context.exists_current?

    headers = Istio::Tracing::Context.current.headers
    Istio::Tracing::PROPAGATION_HEADERS.each do |h|
      req.options[:headers][h] = headers[h] unless headers[h]&.nil?
    end
    req
  end
end
