require File.expand_path File.dirname( __FILE__ ) + '/../spec_helper'

describe "Address Enzyme" do

  before(:each) do
    @rumen = Rumen.new
  end

  after(:each) do
    @rumen = nil
  end
  
  it "should match one-line addresses with all punctuation" do
    @rumen.data = "blah blah 1324 Clubview Dr., Cambridge, MA, 90210 LOL WAT NO U"
    @rumen.digest( "address" )[0].should == "1324 Clubview Dr., Cambridge, MA, 90210"
  end

  it "should match one-line addresses with some punctuation" do
    @rumen.data = "blah blah 1324 Clubview Dr. Cambridge, MA 90210 LOL WAT NO U"
    @rumen.digest( "address" )[0].should == "1324 Clubview Dr. Cambridge, MA 90210"
  end

  it "should match one-line addresses with no punctuation" do
    @rumen.data = "blah blah 1324 Clubview Dr Cambridge MA 90210 LOL WAT NO U"
    @rumen.digest( "address" )[0].should == "1324 Clubview Dr Cambridge MA 90210"
  end

  it "should match multi-word street names" do
    @rumen.data = "blah blah 768 Blue Spruce Cr., Boston MA, 90210 LOL WAT NO U"
    @rumen.digest( "address" )[0].should == "768 Blue Spruce Cr., Boston MA, 90210"
  end

  it "should match multi-line addresses" do
    data = <<-DATA
      42 Roger Street
      Rochester, NY
      90210
    DATA
    @rumen.data = data
    @rumen.digest( "address" )[0].should == data.strip
  end

end

