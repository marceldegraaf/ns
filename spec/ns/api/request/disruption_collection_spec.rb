require 'spec_helper'

describe Ns::Api::Request::DisruptionCollection do

  subject { Ns::Api::Request::DisruptionCollection.new(station: 'asd') }

  it 'has a base_uri' do
    subject.class.base_uri.should == 'http://webservices.ns.nl/ns-api-storingen'
  end

  it 'has a response_class' do
    subject.class.response_class.should == Ns::Api::Response::DisruptionCollection
  end

  describe 'query' do

    let(:query) { subject.send(:query) }

    it 'should have a station' do
      query[:station].should == subject.station
    end

  end

end
