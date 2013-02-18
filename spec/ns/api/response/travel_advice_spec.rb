require 'spec_helper'

describe Ns::Api::Response::TravelAdvice do

  subject { Ns::Api::Response::TravelAdvice.new({}) }

  it 'should not error if parsed response is empty' do
    subject.travel_options.should == []
  end

end
