# frozen_string_literal: true

require 'rack_app'
require 'securerandom'
require 'ygrene_istio_tracing'

RSpec.describe YgreneIstioTracing::Tracing::RackMiddleware do
  let(:app) {RackApp.new}
  subject {described_class.new(app)}
  let(:request) {Rack::MockRequest.new(subject)}
  let(:headers) do
    headers = Hash.new
    YgreneIstioTracing::Tracing::PROPAGATION_HEADERS.each do |h|
      headers.merge! h.upcase => SecureRandom.hex(3)
    end
    headers
  end

  before(:each) do
    headerstyp = headers.merge 'Expect'.upcase => '',
                               'User-Agent'.upcase => 'Typhoeus - https://github.com/typhoeus/typhoeus'
    stub_request(:get, "http://other.service/typh").
        with(headers: headerstyp).
        to_return(status: 200, body: "", headers: headerstyp)
  end

  before(:each) do
    request.get('/some/path', headers)
  end

  it 'has a version number' do
    expect(YgreneIstioTracing::VERSION).not_to be nil
  end

end
