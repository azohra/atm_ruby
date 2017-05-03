# frozen_string_literal: true

require 'spec_helper'

describe 'TMJ::Services::TestCase#create' do
  let(:client) { TMJ::Client.new }
  let(:create_test_case) { client.TestCase.create(simple_test_case_body) }
  let(:simple_test_case_body) { { "projectKey": 'JQA', "name": 'Ensure the axial-flow pump is enabled' } }

  it 'create new test case' do
    stub_request(:post, TMJ.config.base_url + '/rest/kanoahtests/1.0/testcase')
      .to_return(status: 201, body: get_mock_response('test_case/JQA-T123.json'))
    expect(create_test_case.response.code).to eq 201
  end

  it 'some parameters are invalid or not found' do
    stub_request(:post, TMJ.config.base_url + '/rest/kanoahtests/1.0/testcase')
      .to_return(status: 400, body: '')
    expect { create_test_case }.to raise_error(TMJ::TestCaseError)
  end

  it 'authentication error' do
    stub_request(:post, TMJ.config.base_url + '/rest/kanoahtests/1.0/testcase')
      .to_return(status: 401, body: '')
    expect { create_test_case }.to raise_error(TMJ::TestCaseError)
  end

  it 'no test case has been found with the given key' do
    stub_request(:post, TMJ.config.base_url + '/rest/kanoahtests/1.0/testcase')
      .to_return(status: 404, body: '')
    expect { create_test_case }.to raise_error(TMJ::TestCaseError)
  end
end
