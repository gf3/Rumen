require File.expand_path File.dirname( __FILE__ ) + '/../spec_helper'

describe "URL Enzyme" do

  before(:each) do
    @rumen = Rumen.new
  end

  after(:each) do
    @rumen = nil
  end

  it "should match a full URL" do
    @rumen.data = 'lol. :22 data. http://sub.domain.tld:8800/ some junk!'
    @rumen.digest( 'url' ).first.should == 'http://sub.domain.tld:8800/'
  end

  it "should match ugly URLs" do
    @rumen.data = 'LOL look at my ugly URL: http://www.domain.tld/dir/site.php?page=contact&user=jeff#top hahaha'
    @rumen.digest( 'url' ).first.should == 'http://www.domain.tld/dir/site.php?page=contact&user=jeff#top'
  end

  it "should match partial URLs" do
    @rumen.data = 'This is a site: google.ca. We can also match fancy tlds -> google.co.uk. And different protocols as well: ftp://server.com. Not to mention weird formatting: gianni-chiappetta.roflmao.com!'
    matches = @rumen.digest 'url'
    matches[0].should == 'google.ca'
    matches[1].should == 'google.co.uk'
    matches[2].should == 'ftp://server.com'
    matches[3].should == 'gianni-chiappetta.roflmao.com'
  end


  it "should not match email address hosts" do
    @rumen.data = 'user@host.com server.com'
    @rumen.digest( 'url' ).first.should == 'server.com'

    @rumen.data = 'gi@gabc.com'
    @rumen.digest( 'url' ).should be_empty
  end
end

