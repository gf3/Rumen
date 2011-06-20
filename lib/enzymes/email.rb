module Enzymes
  class Email < Enzyme

    REGEXP = /[0-9a-z][\w\d\-\+\.]*\@[a-zA-Z0-9\d\-\.]*\.[a-z]{2,4}/mi

    def digest
      @data.scan REGEXP
    end

  end
end

