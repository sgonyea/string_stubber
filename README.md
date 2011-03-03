# Stubber

Stubber is a simple gem that lets you stub strings, using "words" as the unit of measure.  For example:

        require 'stubber'
        require 'lorem' # Or just add your own text

        str = Lorem::Base.new('paragraphs', 1).output
        # => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat."

        # Get the first 5 words
        str.stub_words(5)
        # => "Lorem ipsum dolor sit amet"

        # Get the NEXT 5 words
        str.stub_words(5, true)
        # => ", consectetuer adipiscing elit. Vivamus vitae"

        # Grab the _complete_ words, appearing _up to_ position 70
        str.stub_to(70)
        # => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus "

        str.stub_to(70).size
        # => 66

        # Grab the _complete_ words, appearing _through_ position 70
        str.stub_thru(70)
        # => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae"

        str.stub_thru(70).size
        # => 71

Now the other direction!

        str.stub_words(-5)
        # => "risus vitae lorem iaculis placerat."

        str.stub_words(-5, true)
        # => "consectetuer adipiscing elit. Vivamus vitae "

        str.stub_to(-45)
        # => " vitae risus vitae lorem iaculis placerat."

        str.stub_to(-45).size
        # => 42

So far, so good!  Suggestions are welcome.

# TODO

*   stubbing from the right direction is simple to do and will be the next addition.
    *   *^* done, needs specs
*   left and right indexes
