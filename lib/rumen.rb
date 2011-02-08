class Rumen
  attr_accessor :data

  @@types = [ :email, :phone, :url ]

  EMAIL_REGEXP  = '[0-9a-z][\w\d\-\+\.]*\@[a-zA-Z0-9\d\-\.]*\.[a-z]{2,4}'
  URL_REGEXP    = '(?:[a-z]+:\/\/)?[0-9a-z](?:[\d\w\-\.]+\.)+[a-z]{2,4}(?:\:[0-9]{1,6})?(?:[\d\w\-\.\/\?=&#%+]*)'
  REGEXPS = { phone_10:     /\+?(?:[0-9][\s\-\.]?)?\(?[0-9]{3}\)?[\s\-\.]?[0-9]{3}[\s\-\.]?[0-9]{4}/m,
              phone_7:      /[0-9]{3}[\s\-\.]?[0-9]{4}/m,
              email:        /#{EMAIL_REGEXP}/mi,
              email_single: /^#{EMAIL_REGEXP}$/mi,
              url:          /#{URL_REGEXP}/mi,
              url_single:   /^#{URL_REGEXP}$/mi
            }

  def initialize( data = nil )
    @data = data
  end

  def digest( type )
    if type.nil?
      results = {}
      @@types.each do |t|
        results[t] = search_for t
      end
    else
        results = search_for type
    end

    results
  end
  
  protected

  def search_for( type )
    results = []

    if type == :url
      @data.scan( REGEXPS[:url] ).each do |match|
        precede = @data[ @data.index( match ) - 1, 1 ]
        succeed = @data[ @data.index( match ) + match.length, 1 ]
        match.chomp! '.'
        results << match unless precede == '@' || succeed == '@'
      end
    elsif type == :phone
      # XXX Dirty 7 digit phone number hack
      phone_data = @data.dup
      phone_data.scan( REGEXPS[:phone_10] ).each { |match| results << match }
      results.each {|r| phone_data.gsub! r, '' }
      phone_data.scan( REGEXPS[:phone_7] ).each { |match| results << match }
    else
      @data.scan( REGEXPS[type] ).each { |match| results << match }
    end

    results
  end
end

