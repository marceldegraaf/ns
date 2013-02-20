require 'spec_helper'

describe Ns::Api::Response::TravelAdvice do

  let(:parsed_response) { double(:parsed_response) }
  let(:travel_options)  { double(:travel_options) }
  let(:travel_option)   { double(:travel_option) }
  subject { Ns::Api::Response::TravelAdvice.new(parsed_response: parsed_response) }

  before do
    parsed_response.stub!(:[]).and_return(travel_options)
    travel_options.stub!(:[]).and_return(travel_option)
  end

  it 'should initialize with a parsed response' do
    subject.parsed_response.should == parsed_response
  end

  it 'should check for the presence of keys' do
    parsed_response.should_receive(:has_key?).with('ReisMogelijkheden').and_return(true)
    parsed_response['ReisMogelijkheden'].should_receive(:has_key?).with('ReisMogelijkheid').and_return(true)

    subject.send(:raw_travel_options)
  end

  it 'should map travel options to Ns::TravelOption objects' do
    subject.stub!(:raw_travel_options).and_return([travel_option])
    Ns::TravelOption.should_receive(:new)

    travel_option.should_receive(:[]).with('GeplandeVertrekTijd')
    travel_option.should_receive(:[]).with('ActueleVertrekTijd')
    travel_option.should_receive(:[]).with('GeplandeAankomstTijd')
    travel_option.should_receive(:[]).with('ActueleAankomstTijd')
    travel_option.should_receive(:[]).with('AantalOverstappen')
    travel_option.should_receive(:[]).with('ReisDeel').and_return([{'ReisStop' => { 'Spoor' => '9a' }}])

    subject.travel_options
  end

  it 'should not error if parsed response is empty' do
    empty = Ns::Api::Response::TravelAdvice.new(parsed_response: {})
    empty.travel_options.should == []
  end

end
