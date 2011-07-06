$LOAD_PATH.unshift File.dirname( __FILE__ ) + '/../lib' unless $LOAD_PATH.include? File.dirname( __FILE__ ) + '/../lib'

require 'rumen/common'
require 'rumen/exceptions'
require 'rumen/registration'
require 'rumen/digestion'

require 'enzyme'
require 'enzymes/address'
require 'enzymes/email'
require 'enzymes/phone'
require 'enzymes/url'

class Rumen
  attr_accessor :data

  @@enzymes = {}

  def initialize data = nil
    @data = data
  end

  def self.enzymes
    @@enzymes
  end

end

