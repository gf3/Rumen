class Phone < Enzyme

  REGEXPS = { phone_10: /\+?(?:[0-9][\s\-\.]?)?\(?[0-9]{3}\)?[\s\-\.]?[0-9]{3}[\s\-\.]?[0-9]{4}/m,
              phone_7:  /[0-9]{3}[\s\-\.]?[0-9]{4}/m,
            }

  def digest
    results = []

    # XXX Dirty 7 digit phone number hack
    @data.scan( REGEXPS[:phone_10] ).each { |match| results << match }
    results.each {|r| @data.gsub! r, '' }
    @data.scan( REGEXPS[:phone_7] ).each { |match| results << match }

    results
  end

end


