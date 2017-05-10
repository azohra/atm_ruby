require 'spec_helper'

describe TMJ::Services::TestCase do
  let(:test_case_id) { 'JQA-T123' }
  let(:search_query) { 'projectKey = "JQA"' }
  let(:update_test_case_body) {
    {
     "name": "Ensure the axial-flow pump is enabled"
    }
  }
  let(:client) { TMJ::Client.new }



  it 'update a test case matching a given key' do
    stub_request(:put, TMJ.config.base_url + '/rest/kanoahtests/1.0/testcase/JQA-T123')
      .to_return(status: 200, body: '')

    test_case = client.TestCase.update('JQA-T123', update_test_case_body)
    expect(test_case.response.code).to eq '200'
  end

  it 'find a test case matching a given key' do
    stub_request(:get, TMJ.config.base_url + '/rest/kanoahtests/1.0/testcase/JQA-T123')
      .to_return(status: 200, body: get_mock_response('test_case/JQA-T123.find.get.json'))

    test_case = client.TestCase.find('JQA-T123')
    expect(test_case.response.code).to eq '200'
  end

  it 'delete a test case matching a given key' do
    stub_request(:delete, TMJ.config.base_url + '/rest/kanoahtests/1.0/testcase/JQA-T123')
      .to_return(status: 204, body: '')

    test_case = client.TestCase.delete('JQA-T123')
    expect(test_case.response.code).to eq '204'
  end

  it 'search for a test case based on the passed quiry' do
    stub_request(:get, TMJ.config.base_url + '/rest/kanoahtests/1.0/testcase/search?query=projectKey = "JQA"')
      .to_return(status: 200, body: get_mock_response('test_case/JQA-T123.search.get.json'))

    test_case = client.TestCase.search(search_query)
    expect(test_case.response.code).to eq '200'
  end
end
