# http://en.wikipedia.org/wiki/Street_or_road_name
module Enzymes
  class Address < Enzyme

    STREET_TYPES = %w{ Alley Aly Avenue Ave Bay Boulevard Blvd Circle Circ Close Court Ct Cove Cv Crescent Cr Croft Drive Dr Gardens Gdns Gate Heights Hts Highway Hwy Lane Loop Manor Mnr Passage Psg Park Parkway Pkwy Pathway Pthwy Place Pl Row Square Sq Street St Terrace Ter Trail Trl View Way }
    STATES = %w{ Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota Mississippi Missouri Montana Nebraska Nevada Ohio Oklahoma Oregon Pennsylvania Rhode Island South Carolina Tennessee Texas Utah Vermont Virginia Washington Wisconsin Wyoming } + [ "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "South Dakota", "West Virginia" ]
    STATES_ABBR = %w{ AL AK AS AZ AR CA CO CT DE DC FM FL GA GU HI ID IL IN IA KS KY LA ME MH MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND MP OH OK OR PW PA PR RI SC SD TN TX UT VT VI VA WA WV WI WY AE AA AP }
       
    REGEXP = Regexp.new <<-REGEXP.gsub( /\s/, '' )
      (?# Street Number )
      \\d+ \\s+

      (?# Street Name )
      (?:\\w+ \\s+)+

      (?# Street Type )
      (?:#{STREET_TYPES.join '|'}) \\.? ,? \\s*

      (?# City )
      (?:\\w+ \\s?)+ ,? \\s*

      (?# State )
      (?:#{(STATES + STATES_ABBR).join '|'}) ,? \\s*

      (?# Zip )
      \\d{5} (?:-?\\d{4})?

    REGEXP

    def digest
      @data.scan REGEXP
    end

  end
end

