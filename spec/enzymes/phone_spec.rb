require File.expand_path File.dirname( __FILE__ ) + '/../spec_helper'

describe "Phone Enzyme" do

  before(:each) do
    @rumen = Rumen.new
  end

  after(:each) do
    @rumen = nil
  end

  it "should match various phone number formats" do
    @rumen.data = 'Some bad phone numbers: 123456, 123-456, +123456 7. Some valid phone numbers: 1234567890, 123-456-7890, 123.456.7890, (123) 456 7890, 123 456-7890, 123.4567, 123-4567, 123 4567.'
    matches = @rumen.digest 'phone'
    matches[0].should == '1234567890'
    matches[1].should == '123-456-7890'
    matches[2].should == '123.456.7890'
    matches[3].should == '(123) 456 7890'
    matches[4].should == '123 456-7890'
    matches[5].should == '123.4567'
    matches[6].should == '123-4567'
    matches[7].should == '123 4567'
  end

  it "should match international phone numbers" do
    @rumen.data = '+14161234567, 1 (416) 123 4567, +1.416.123-4567'
    matches = @rumen.digest 'phone'
    matches[0].should == '+14161234567'
    matches[1].should == '1 (416) 123 4567'
    matches[2].should == '+1.416.123-4567'
  end

end

