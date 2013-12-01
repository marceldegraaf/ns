require 'spec_helper'

describe Ns::Api::Request::DepartureCollection do

  let(:departure_collection) { Ns::DepartureCollection.new(station: 'klp') }
  subject { Ns::Api::Request::DepartureCollection.new(departure_collection: departure_collection) }

  it 'has a base_uri' do
    subject.class.base_uri.should == 'http://webservices.ns.nl/ns-api-avt'
  end

  it 'has a response_class' do
    subject.class.response_class.should == Ns::Api::Response::DepartureCollection
  end

  describe 'query' do

    let(:query) { subject.send(:query) }

    it 'should have a station' do
      query[:station].should == departure_collection.station
    end

  end

end
