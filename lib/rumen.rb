$LOAD_PATH.unshift File.dirname( __FILE__ ) + '/../lib' unless $LOAD_PATH.include? File.dirname( __FILE__ ) + '/../lib'

require 'rumen/common'
require 'rumen/exceptions'
require 'rumen/registration'
require 'rumen/digestion'

require 'enzyme'
Dir.chdir 'lib' do
  Dir[ 'enzymes/*.rb' ].each {|file| require file }
end

class Rumen
  attr_accessor :data

  @@enzymes = {}

  def initialize data = nil
    @data = data
  end

end

