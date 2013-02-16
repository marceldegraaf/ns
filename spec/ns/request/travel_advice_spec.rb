require 'spec_helper'

describe Ns::Request::TravelAdvice do

  let(:trip) { Ns::Trip.new('edc', 'asd', departure: Time.now) }
  subject    { Ns::Request::TravelAdvice.new(trip) }

  it 'has a base uri' do
    subject.class.base_uri.should == 'http://webservices.ns.nl/ns-api-treinplanner'
  end

  it 'has a trip' do
    subject.trip.should == trip
  end

  describe 'query' do

    let(:query) { subject.send(:query) }

    it 'should have a fromStation' do
      query[:fromStation].should == trip.from.name
    end

    it 'should have a toStation' do
      query[:toStation].should == trip.to.name
    end

    it 'should have a dateTime' do
      query[:dateTime].should == trip.formatted_time
    end

    it 'should have a departure' do
      query[:departure].should == trip.departure?
    end

    it 'should have a hslAllowed' do
      query[:hslAllowed].should == trip.allow_hsl
    end

    it 'should have a yearCard' do
      query[:yearCard].should == trip.year_card
    end

  end

end
