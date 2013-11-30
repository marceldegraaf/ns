require 'spec_helper'

describe Ns::DepartureCollection do

  subject { Ns::DepartureCollection.new(station: 'klp') }

  let(:xml_with_departures)  { File.read(File.join($ROOT, 'spec/fixtures/ns_departures_response.xml')) }
  let(:response)             { double('response') }
  let(:departure_collection) { double('departure_collection') }

  before do
    response.stub!(:departures)
    departure_collection.stub!(:response).and_return(response)
    subject.stub!(:departure_collection).and_return(departure_collection)
  end

  it 'should fetch a list of planned disruptions around a station' do
    subject.departures
  end

  it 'has a departure collection' do
    object = Ns::DepartureCollection.new(station: 'klp')
    lambda { object.send(:departure_collection) }.should_not raise_error
  end

end
