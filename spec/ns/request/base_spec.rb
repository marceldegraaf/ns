require 'spec_helper'

describe Ns::Request::Base do

  class Dummy < Ns::Request::Base; end

  subject { Ns::Request::Base.new }

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

    subject.send(:url_for_request).to_s.should == 'http://foo.com?foo=bar'
  end

  it 'should perform the request' do
    url_for_request = HTTPI::Request.new('http://foo.com').url
    subject.stub!(:url_for_request).and_return(url_for_request)

    HTTPI.should_receive(:get).with(url_for_request)

    subject.perform
  end

end
