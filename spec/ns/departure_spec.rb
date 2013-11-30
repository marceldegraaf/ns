require 'spec_helper'

describe Ns::Departure do

  let(:trip_number)       { 123 }
  let(:departure_time)    { DateTime.now }
  let(:destination)       { 'Den Helder' }
  let(:train_type)        { 'Intercity' }
  let(:route)             { 'Via Utrecht, Amsterdam, Zaandam' }
  let(:company)           { 'NS' }
  let(:platform)          { '2' }
  let(:travel_tip)        { 'Stopt niet in Arnhem zuid' }
  let(:comments)          { ['Rijdt vandaag niet'] }

  subject {
    Ns::Departure.new(
      trip_number:    trip_number,
      departure_time: departure_time,
      destination:    destination,
      train_type:     train_type,
      route:          route,
      company:        company,
      platform:       platform,
      travel_tip:     travel_tip,
      comments:       comments
    )
  }

  it 'should initialize properly' do
    %w(trip_number departure_time destination train_type route company platform).each do |var|
      subject.send(var).should == send(var)
    end
  end

end
