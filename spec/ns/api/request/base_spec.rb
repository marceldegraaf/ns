require 'spec_helper'

describe Ns::Api::Request::Base do

  class Dummy < Ns::Api::Request::Base; end
  class DummyResponse; end

  subject { Ns::Api::Request::Base.new }

  let(:xml)      { File.read(File.join($ROOT, 'spec/fixtures/ns_travel_advice_response.xml')) }
  let(:response) { HTTPI::Response.new(200, [], xml) }

  it 'should disable HTTPI logging' do
    HTTPI.should_receive(:log=).with(false)
    Dummy.new
  end

  it 'should not implement base_uri' do
    lambda { subject.class.send(:base_uri) }.should raise_error
  end

  it 'should not implement query' do
    lambda { subject.send(:query) }.should raise_error
  end

  it 'should not implement response_class' do
    lambda { subject.class.send(:response_class) }.should raise_error
  end

  it 'should have an http request' do
    HTTPI::Request.should_receive(:new)
    subject.class.stub!(:base_uri).and_return('http://foo.com')
    subject.send(:http_request)
  end

  it 'should set the query' do
    request = HTTPI::Request.new('http://foo.com')
    HTTPI::Request.stub!(:new).and_return(request)
    request.should_receive(:query=).with(an_instance_of(Hash))
    subject.stub!(:query).and_return({foo: 'bar'})
    subject.class.stub!(:base_uri).and_return('http://foo.com')

    subject.send(:http_request_with_query)
  end

  it 'should return the url for the request' do
    request = HTTPI::Request.new('http://foo.com')
    subject.stub!(:http_request).and_return(request)
    subject.stub!(:query).and_return({foo: 'bar'})

    subject.send(:url_for_request).should be_an_instance_of(HTTPI::Request)
  end

  it 'should fetch the plain text response body' do
    subject.class.stub!(:base_uri).and_return('http://foo.com')
    subject.stub!(:query).and_return({})
    HTTPI.should_receive(:get).and_return(response)
    response.should_receive(:body)

    subject.send(:response_body)
  end

end
