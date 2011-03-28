class Rumen

  protected

  def self.register klass
    @@enzymes[ klass.human_name ] ||= klass
  end

  def self.auto_register
    Enzyme.subclasses.each &:register
  end

end

