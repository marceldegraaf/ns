require 'spec_helper'

describe Ns::DisruptionCollection do

  subject { Ns::DisruptionCollection.new(station: 'asd') }

  let(:xml_with_disruptions)  { File.read(File.join($ROOT, 'spec/fixtures/ns_disruptions_with_results.xml')) }
  let(:xml_no_disruptions)    { File.read(File.join($ROOT, 'spec/fixtures/ns_disruptions_no_results.xml')) }
  let(:response)              { double('response') }
  let(:disruption_collection) { double('disruption_collection') }

  before do
    response.stub!(:planned_disruptions)
    response.stub!(:unplanned_disruptions)
    disruption_collection.stub!(:response).and_return(response)
    subject.stub!(:disruption_collection).and_return(disruption_collection)
  end

  it 'should fetch a list of planned disruptions around a station' do
    subject.planned_disruptions
  end

  it 'should fetch a list of unplanned disruptions around a station' do
    subject.unplanned_disruptions
  end

end
