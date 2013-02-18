require 'spec_helper'

describe Ns::Trip do

  subject { Ns::Trip.new('edc', 'asd', departure: (Time.now + 3600)) }

  let(:time1) { Time.now + 3600 }
  let(:time2) { Time.now + 8600 }
  let(:xml)   { File.read(File.join($ROOT, 'spec/fixtures/ns_travel_advice_response.xml')) }
  let(:departure_trip)    { Ns::Trip.new('edc', 'asd', departure: time1) }
  let(:arrival_trip)      { Ns::Trip.new('edc', 'asd', arrival: time2) }
  let(:trip_without_time) { Ns::Trip.new('edc', 'asd') }

  it 'should map origin and destination to station classes' do
    subject.from.class.should == Ns::Station
    subject.to.class.should == Ns::Station
  end

  it 'has a time' do
    departure_trip.time.should == time1
    arrival_trip.time.should == time2
  end

  it 'has a default time' do
    Time.should_receive(:now)
    trip_without_time.time
  end

  it 'defaults to arrival if no time given' do
    trip_without_time.departure?.should == false
  end

  it 'has a formatted time' do
    departure_trip.formatted_time.should == time1.iso8601
    arrival_trip.formatted_time.should == time2.iso8601
  end

  it 'tells wether it is a departure or arrival time' do
    departure_trip.departure?.should == true
    arrival_trip.departure?.should == false
  end

  it 'has travel options' do
    travel_advice = Ns::Api::Request::TravelAdvice.new(subject)
    Ns::Api::Request::TravelAdvice.stub!(:new).and_return(travel_advice)
    travel_advice.stub!(:response_body).and_return(xml)

    travel_options = subject.travel_options

    travel_options.size.should == 14
    travel_options.map(&:class).uniq.should == [Ns::TravelOption]
  end

  describe 'validations' do

    let(:trip1) { Ns::Trip.new('edc', 'asd') }
    let(:trip2) { Ns::Trip.new('edc', 'asd', departure: '') }
    let(:trip3) { Ns::Trip.new('edc', 'asd', arrival: '') }
    let(:trip4) { Ns::Trip.new('edc', 'asd', departure: Time.now) }
    let(:trip5) { Ns::Trip.new('edc', 'asd', arrival: Time.now) }
    let(:trip6) { Ns::Trip.new('edc', 'asd', arrival: Date.today) }

    it 'should validate departure/arrival times' do
      trip1.valid?.should == false
      trip2.valid?.should == false
      trip3.valid?.should == false
      trip4.valid?.should == true
      trip5.valid?.should == true
      trip6.valid?.should == false
    end

  end

end
