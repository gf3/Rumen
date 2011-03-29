require File.expand_path File.dirname( __FILE__ ) + '/spec_helper'


describe Enzyme do
  
  it "should throw a NotImplementedError if the digest method is called directly" do
    lambda { Enzyme.new("").digest }.should raise_error NotImplementedError
  end

end

