require File.expand_path File.dirname( __FILE__ ) + '/../spec_helper'

describe "Rumen Common" do
  before(:all) do
    class RspecFakeEnzyme; include Rumen::Common; end
    class LOLRspecFakeEnzyme; include Rumen::Common; end
  end

  it "should properly generate the human name" do
    Enzyme.human_name.should == "enzyme"

    RspecFakeEnzyme.human_name.should == "rspec fake enzyme"

    LOLRspecFakeEnzyme.human_name.should == "lol rspec fake enzyme"
  end

  it "should accuratly report it's subclasses" do
    pending "Not critical"
  end

end

