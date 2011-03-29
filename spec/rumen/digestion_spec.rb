require File.expand_path File.dirname( __FILE__ ) + '/../spec_helper'

describe "Rumen Digestion" do

  before(:each) do
    @rumen = Rumen.new ''
  end

  after(:each) do
    @rumen = nil
  end
  
  it "should auto register all enzymes at digest time" do
    Rumen.should_receive :auto_register
    @rumen.digest
  end

  it "should digest all registered enzymes if one isn't provided" do
    result = @rumen.digest
    Rumen.class_variable_get( :@@enzymes ).each do | name, klass |
      result.should have_key( name )
    end
  end

end

