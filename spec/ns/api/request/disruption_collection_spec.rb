require 'spec_helper'

describe Ns::Api::Request::DisruptionCollection do

  let(:disruption_collection) { Ns::DisruptionCollection.new(station: 'asd') }
  subject { Ns::Api::Request::DisruptionCollection.new(disruption_collection: disruption_collection) }

  it 'has a base_uri' do
    subject.class.base_uri.should == 'http://webservices.ns.nl/ns-api-storingen'
  end

  it 'has a response_class' do
    subject.class.response_class.should == Ns::Api::Response::DisruptionCollection
  end

  describe 'query' do

    let(:query) { subject.send(:query) }

    it 'should have a station' do
      query[:station].should == disruption_collection.station
    end

    it 'should have an actual' do
      query[:actual].should == disruption_collection.actual
    end

    it 'should have an include_planned' do
      query[:unplanned].should == disruption_collection.include_planned
    end

  end

end
