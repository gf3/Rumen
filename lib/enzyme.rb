class Enzyme

  def initialize data
    @data = data
  end

  def digest
    raise NotImplementedError
  end

  def self.human_name
    self.name.gsub( /([A-Z]+)/, ' \1' ).strip.downcase
  end

  def self.register
    Rumen.register self
  end

  # Interesting solution found at: http://snippets.dzone.com/posts/show/2992
  def self.subclasses direct = false
    classes = []
    if direct
      ObjectSpace.each_object( Class ) do |c|
        next unless c.superclass == self
        classes << c
      end
    else
      ObjectSpace.each_object( Class ) do |c|
        next unless c.ancestors.include? self and ( c != self )
        classes << c
      end
    end
    classes
  end
  
end
