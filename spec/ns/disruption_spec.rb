require 'spec_helper'

describe Ns::Disruption do

  let(:route)   { 'Amsterdam Centraal - Ede Centrum' }
  let(:reason)  { '       Op last van         de politie' }
  let(:message) { 'Bericht         met           spaties     ' }
  let(:advice)  { 'Maak gebruik van overige           treinen of       bussen' }
  let(:period)  { 'Zaterdag 18 en zondag 19 december' }

  subject {
    Ns::Disruption.new(
      route:   route,
      reason:  reason,
      message: message,
      advice:  advice,
      period:  period
    )
  }

  it 'initializes properly' do
    %w(route period).each do |var|
      subject.send(var).should == send(var)
    end
  end

  it 'strips and cleans strings of excess spaces' do
    subject.reason.should  == 'Op last van de politie'
    subject.message.should == 'Bericht met spaties'
    subject.advice.should  == 'Maak gebruik van overige treinen of bussen'
  end

end
