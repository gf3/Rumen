class Rumen

  def digest type = nil
    self.class.auto_register

    if type.nil?
      results = {}
      @@enzymes.each do | name, klass |
        results[ name ] = klass.new( @data.dup ).digest
      end
    else
      throw EnzymeNotFoundException.new( type ) if @@enzymes[ type ].nil?
      results = @@enzymes[ type ].new( @data.dup ).digest
    end

    results
  end
  
end

