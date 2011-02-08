require 'rumen'

describe Rumen do
  
  before(:each) do
    @rumen = Rumen.new
  end
  
  it "should match a full URL" do
    @rumen.data = 'lol. :22 data. http://sub.domain.tld:8800/ some junk!'
    @rumen.digest(:url).first.should == 'http://sub.domain.tld:8800/'
  end
  
  it "should match ugly URLs" do
    @rumen.data = 'LOL look at my ugly URL: http://www.domain.tld/dir/site.php?page=contact&user=jeff#top hahaha'
    @rumen.digest(:url).first.should == 'http://www.domain.tld/dir/site.php?page=contact&user=jeff#top'
  end
  
  it "should match partial URLs" do
    @rumen.data = 'This is a site: google.ca. We can also match fancy tlds -> google.co.uk. And different protocols as well: ftp://server.com. Not to mention weird formatting: gianni-chiappetta.roflmao.com!'
    matches = @rumen.digest :url 
    matches[0].should == 'google.ca'
    matches[1].should == 'google.co.uk'
    matches[2].should == 'ftp://server.com'
    matches[3].should == 'gianni-chiappetta.roflmao.com'
  end
  
  it "should not match the period at the end of an email address" do
    @rumen.data = 'user@host.com.'
    matches = @rumen.digest :email 
    matches[0].should == 'user@host.com'
  end
  
  it "should not match email address hosts" do
    @rumen.data = 'user@host.com server.com'
    @rumen.digest(:url).first.should == 'server.com'
    
    @rumen.data = 'gi@gabc.com'
    @rumen.digest(:url).should be_empty
  end
  
  it "should match various email address formats" do 
    @rumen.data = 'First some bad formats: xxx@test.x, @fail, @fail.com, someone@blahblah, bob@billy+bob.com. Here are some valid formats: user@bighost.com, user@bighost.co.uk, user@big-host.com.au, user.name@big.host.com, user-name@big-h.ost.ca, user@bighost.info, user.has.a.long.name@big.host.name.lol.com, user_name@host.com, a+b@host.com a+b+c@host.com'
    matches = @rumen.digest :email 
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
  
  it "should match various phone number formats" do
    @rumen.data = 'Some bad phone numbers: 123456, 123-456, +123456 7. Some valid phone numbers: 1234567890, 123-456-7890, 123.456.7890, (123) 456 7890, 123 456-7890, 123.4567, 123-4567, 123 4567.'
    matches = @rumen.digest :phone 
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
    matches = @rumen.digest :phone 
    matches[0].should == '+14161234567'
    matches[1].should == '1 (416) 123 4567'
    matches[2].should == '+1.416.123-4567'
  end
  
  after(:each) do
    @rumen = nil
  end
  
end

