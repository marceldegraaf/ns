require 'spec_helper'

describe Ns::Api::Response::DisruptionCollection do

  let(:parsed_response)       { double(:parsed_response) }
  let(:disruption_collection) { double(:disruption_collection) }
  let(:raw_disruption)        { double(:raw_disruption) }
  let(:planned_disruptions)   { [ [ 'Storing', raw_disruption ] ] }
  let(:unplanned_disruptions) { [ [ 'Storing', raw_disruption ] ] }
  subject { Ns::Api::Response::DisruptionCollection.new(parsed_response: parsed_response) }

  before do
    parsed_response.stub!(:[]).with('Storingen').and_return(disruption_collection)
    disruption_collection.stub!(:[]).with('Gepland').and_return(planned_disruptions)
    disruption_collection.stub!(:[]).with('Ongepland').and_return(unplanned_disruptions)
  end

  it 'should not error if parsed response is empty' do
    empty = Ns::Api::Response::DisruptionCollection.new(parsed_response: {})

    empty.planned_disruptions.should == []
    empty.unplanned_disruptions.should == []
  end

  it 'should fetch planned disruptions' do
    parsed_response.should_receive(:has_key?).with('Storingen').and_return(true)
    disruption_collection.should_receive(:has_key?).and_return(true)
    raw_disruption.should_receive(:[]).any_number_of_times.and_return('')
    Ns::Disruption.should_receive(:new)

    subject.planned_disruptions
  end

  it 'should fetch unplanned disruptions' do
    parsed_response.should_receive(:has_key?).with('Storingen').and_return(true)
    disruption_collection.should_receive(:has_key?).and_return(true)
    raw_disruption.should_receive(:[]).any_number_of_times.and_return('')
    Ns::Disruption.should_receive(:new)

    subject.unplanned_disruptions
  end

end
