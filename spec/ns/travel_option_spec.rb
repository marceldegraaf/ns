require 'spec_helper'

describe Ns::TravelOption do

  let(:planned_departure) { DateTime.now }
  let(:actual_departure)  { DateTime.now + (80.0 / 60 / 60 / 24) }
  let(:planned_arrival)   { planned_departure + (3600.0 / 60 / 60 / 24) }
  let(:actual_arrival)    { actual_departure + (3600.0 / 60 / 60 / 24) }
  let(:changes)           { 2 }
  let(:platform)          { '9a' }

  subject {
    Ns::TravelOption.new(
      planned_departure: planned_departure,
      actual_departure:  actual_departure,
      planned_arrival:   planned_arrival,
      actual_arrival:    actual_arrival,
      changes:           changes,
      platform:          platform
    )
  }

  it 'should initialize properly' do
    %w(planned_departure actual_departure planned_arrival actual_arrival changes platform).each do |var|
      subject.send(var).should == send(var)
    end
  end

  it 'should calculate the planned duration' do
    subject.planned_duration.should == 3600
  end

  it 'should calculate the actual duration' do
    subject.actual_duration.should == 3600
  end

  it 'should calculate the delay' do
    subject.delay.should == 80
  end

end
