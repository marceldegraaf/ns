require 'spec_helper'

describe Ns::Trip do

  subject { Ns::Trip.new('edc', 'asd', departure: (Time.now + 3600)) }

  it 'should map origin and destination to station classes' do
    subject.from.class.should == Ns::Station
    subject.to.class.should == Ns::Station
  end

  describe 'validations' do

    let(:trip1) { Ns::Trip.new('edc', 'asd') }
    let(:trip2) { Ns::Trip.new('edc', 'asd', departure: '') }
    let(:trip3) { Ns::Trip.new('edc', 'asd', arrival: '') }
    let(:trip4) { Ns::Trip.new('edc', 'asd', departure: Time.now) }
    let(:trip5) { Ns::Trip.new('edc', 'asd', arrival: Time.now) }

    it 'should validate departure/arrival times' do
      trip1.valid?.should == false
      trip2.valid?.should == false
      trip3.valid?.should == false
      trip4.valid?.should == true
      trip5.valid?.should == true
    end

  end

end
