require 'spec_helper'

describe TMJ::Client do
  let(:header) { { 'Authorization' => 'Basic VGVzdDp0ZXN0', 'Content-Type' => 'application/json' } }
  let(:unsupported_auth) { TMJ::Client.new(auth_type: :cookie) }

  it 'error is shown when unsupported auth_type provided' do
    expect { unsupported_auth }.to raise_error(StandardError)
  end
end
