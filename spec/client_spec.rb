require 'spec_helper'

RSpec.describe ATM::Client do
  let(:unsupported_auth) { ATM::Client.new(auth_type: :cookie) }

  it 'succefully authenticate' do
    expect(subject.gen_auth_token).to eql('VGVzdDp0ZXN0')
  end

  it 'error is shown when unsupported auth_type provided' do
    expect { unsupported_auth }.to raise_error(StandardError)
  end
end
