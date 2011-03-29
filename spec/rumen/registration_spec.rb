require File.expand_path File.dirname( __FILE__ ) + '/../spec_helper'

describe "Rumen Registration" do

  before(:each) do
    @rumen = Rumen.new ''
  end

  after(:each) do
    @rumen = nil
  end
  
  it "should only register enzyme subclasses" do
    Rumen.register String
    Rumen.class_variable_get( :@@enzymes ).values.should_not include( String )
  end

  it "should properly register enzymes" do
    # Use default enzymes
    Enzyme.subclasses.length.should be > 0
    Rumen.auto_register
    Rumen.class_variable_get( :@@enzymes ).each do | name, klass |
      name.should == klass.human_name
    end
  end

  it "should call register on all enzyme subclasses when autoloading" do
    # Use default enzymes
    Enzyme.subclasses.length.should be > 0
    Enzyme.subclasses.each do |klass|
      klass.should_receive :register
    end
    Rumen.auto_register
  end

end

