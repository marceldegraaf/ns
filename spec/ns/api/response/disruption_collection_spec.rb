require 'spec_helper'

describe Ns::Api::Response::DisruptionCollection do

  subject { Ns::Api::Response::DisruptionCollection.new({}) }

  it 'should not error if parsed response is empty' do
    subject.planned_disruptions.should == []
    subject.unplanned_disruptions.should == []
  end

end
