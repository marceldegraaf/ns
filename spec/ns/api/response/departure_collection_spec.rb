require 'spec_helper'

describe Ns::Api::Response::DepartureCollection do

  let(:parsed_response)      { double(:parsed_response) }
  let(:departure_collection) { double(:departure_collection) }
  let(:departures)           { {'VertrekkendeTrein' => [{}]} }
  subject { Ns::Api::Response::DepartureCollection.new(parsed_response: parsed_response) }

  before do
    parsed_response.stub!(:[]).with('ActueleVertrekTijden').and_return(departures)
  end

  it 'should not error if parsed response is empty' do
    empty = Ns::Api::Response::DepartureCollection.new(parsed_response: {})

    empty.departures.should == []
  end

  it 'should fetch departures' do
    parsed_response.should_receive(:has_key?).with('ActueleVertrekTijden').and_return(true)
    parsed_response.should_receive(:[]).any_number_of_times.and_return(departures)
    Ns::Departure.should_receive(:new)

    subject.departures
  end

end
