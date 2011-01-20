# StringStubber

String Stubber is a simple gem that lets you stub strings, using "words" as the unit of measure.  For example:

        require 'string_stubber'
        require 'lorem' # Or just add your own text

        str = Lorem::Base.new('paragraphs', 1).output
        # => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus ..."

        # Get the first 5 words
        str.stub_words(5)
        # => "Lorem ipsum dolor sit amet"

        # Get the NEXT 5 words
        str.stub_words(5, true)
        # => ", consectetuer adipiscing elit. Vivamus vitae"

        # Grab the _complete_ words, appearing _up to_ position 20
        str.stub_to(70)
        # => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus "

        str.stub_to(70).size
        # => 66

        # Grab the _complete_ words, appearing _through_ position 20
        str.stub_thru(70)
        # => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus  risus"
        str.stub_thru(70).size
        # => 72

So far, so good!  Suggestions are welcome.

# TODO

stubbing from the right direction is simple to do and will be the next addition.
