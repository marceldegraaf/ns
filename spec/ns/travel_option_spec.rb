require 'spec_helper'

describe Ns::TravelOption do

  let(:planned_departure) { Time.now + 60 }
  let(:actual_departure)  { Time.now + 80 }
  let(:planned_arrival)   { planned_departure + 3600 }
  let(:actual_arrival)    { actual_departure + 3600 }
  let(:changes)           { 2 }

  subject {
    Ns::TravelOption.new(
      planned_departure: planned_departure,
      actual_departure:  actual_departure,
      planned_arrival:   planned_arrival,
      actual_arrival:    actual_arrival,
      changes:           changes
    )
  }

  it 'should initialize properly' do
    %w(planned_departure actual_departure planned_arrival actual_arrival changes).each do |var|
      subject.send(var).should == send(var)
    end
  end

  it 'should calculate the planned duration' do
    subject.planned_duration.should == 3600
  end

  it 'should calculate the actual duration' do
    subject.actual_duration.should == 3600
  end

end
