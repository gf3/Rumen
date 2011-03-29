require File.expand_path File.dirname( __FILE__ ) + '/../spec_helper'

describe "Email Enzyme" do

  before(:each) do
    @rumen = Rumen.new
  end

  after(:each) do
    @rumen = nil
  end

  it "should not match the period at the end of an email address" do
    @rumen.data = 'user@host.com.'
    matches = @rumen.digest 'email'
    matches[0].should == 'user@host.com'
  end

  it "should match various email address formats" do
    @rumen.data = 'First some bad formats: xxx@test.x, @fail, @fail.com, someone@blahblah, bob@billy+bob.com. Here are some valid formats: user@bighost.com, user@bighost.co.uk, user@big-host.com.au, user.name@big.host.com, user-name@big-h.ost.ca, user@bighost.info, user.has.a.long.name@big.host.name.lol.com, user_name@host.com, a+b@host.com a+b+c@host.com'
    matches = @rumen.digest 'email'
    matches[0].should == 'user@bighost.com'
    matches[1].should == 'user@bighost.co.uk'
    matches[2].should == 'user@big-host.com.au'
    matches[3].should == 'user.name@big.host.com'
    matches[4].should == 'user-name@big-h.ost.ca'
    matches[5].should == 'user@bighost.info'
    matches[6].should == 'user.has.a.long.name@big.host.name.lol.com'
    matches[7].should == 'user_name@host.com'
    matches[8].should == 'a+b@host.com'
    matches[9].should == 'a+b+c@host.com'
  end

end

