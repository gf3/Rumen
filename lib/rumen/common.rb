class Rumen
  module Common

    # Class methods
    def self.included base
      base.extend ClassMethods
    end
      
    module ClassMethods
      def human_name
        self.name.gsub( /([A-Z]+)([A-Z][a-z]+)/, '\1 \2' ).gsub( /([A-Z]+)/, ' \1' ).strip.downcase.squeeze ' '
      end

      # Interesting solution found at: http://snippets.dzone.com/posts/show/2992
      def subclasses direct = false
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

  end
end

