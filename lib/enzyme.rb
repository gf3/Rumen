class Enzyme
  include Rumen::Common

  def initialize data
    @data = data
  end

  def digest
    raise NotImplementedError
  end

  def self.register
    Rumen.register self
  end

end
