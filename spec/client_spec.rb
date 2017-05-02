require 'spec_helper'

describe TMJ::Client do
  let(:header) { {"Authorization"=>"Basic VGVzdDp0ZXN0", "Content-Type"=>"application/json"} }
  let(:basic_auth) { TMJ::Client.new(auth_type: :basic)}

  it 'header is generated correctly for basic_auth' do
    expect(basic_auth.header).to eql(header)
  end
end
