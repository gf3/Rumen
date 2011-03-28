class Url < Enzyme

  REGEXP = /(?:[a-z]+:\/\/)?[0-9a-z](?:[\d\w\-\.]+\.)+[a-z]{2,4}(?:\:[0-9]{1,6})?(?:[\d\w\-\.\/\?=&#%+]*)/mi

  def digest
    results = []

    @data.scan( REGEXP ).each do |match|
      precede = @data[ @data.index( match ) - 1, 1 ]
      succeed = @data[ @data.index( match ) + match.length, 1 ]
      match.chomp! '.'
      results << match unless precede == '@' || succeed == '@'
    end

    results
  end

end

