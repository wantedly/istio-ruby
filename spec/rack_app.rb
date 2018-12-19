# frozen_string_literal: true
require 'ygrene_istio_tracing'
require 'httparty'

class RackApp
  attr_reader :request_body

  def initialize
    @request_headers = {}
  end

  def call(env)
    @env = env
    @request_body = env['rack.input'].read

    Typhoeus.get('other.service/typh')

    [200, { 'Content-Type' => 'text/plain' }, ['OK']]
  end

  def [](key)
    @env[key]
  end
end
