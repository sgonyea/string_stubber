require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe StringStubber::Base do
  describe 'The Base module should behave like a proper mix-in ;)' do
    before :each do
      @methods = [ :stub_words, :stub_text, :scan_word, :scan_words, :scan_text ]
    end

    it 'should have class methods available' do
      class TestMixin
        extend StringStubber::Base
      end

      @methods.each {|method|
        TestMixin.respond_to?(method).should  be_true
      }
    end
  end # Should be a Mix-In

  describe 'The stubbing methods should behave as expected (Docs check)' do
    before :each do
      @text =  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. "
      @text << "Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi "
      @text << "blandit mollis magna. Suspendisse eu tortor. Donec vitae felis nec ligula blandit rhoncus. Ut a pede ac neque "
      @text << "mattis facilisis. Nulla nunc ipsum, sodales vitae, hendrerit non, imperdiet ac, ante. Morbi sit amet mi. Ut "
      @text << "magna. Curabitur id est. Nulla velit. Sed consectetuer sodales justo. Aliquam dictum gravida libero. Sed eu "
      @text << "turpis. Nunc id lorem. Aenean consequat tempor mi. Phasellus in neque. Nunc fermentum convallis ligula."

      @count = @text.split(/\W+/).count
    end

    describe 'Method: stub_words' do
      it 'should return the expected number of words' do
        StringStubber.stub_words(@text, 10).split(/\W+/).count.should  be(10)
      end

      it 'should always return a string' do
        stubs = [
          StringStubber.stub_words(@text,  -100),
          StringStubber.stub_words(@text,    -1),
          StringStubber.stub_words(@text,     0),
          StringStubber.stub_words(@text,    10),
          StringStubber.stub_words(@text,   100)
        ]

        stubs.each {|stub|
          stub.is_a?(String).should be_true
        }
      end

      it 'should never have trailing spaces' do
        @count.times {|x|
          (StringStubber.stub_words(@text, x) !~ /\s+[\s\W]+$/).should be_true
        }
      end

      it 'Should only have trailing non-words if they immediately follow words' do
        regex   = /[^\w\s]/
        scanner = StringScanner.new(@text)
        count   = @text.split(/[^\w\s]/).count
        puncts  = Hash[ count.times.map {
                          scanner.scan_until(regex)
                          [scanner.pre_match.split.count, scanner.pos - 1]
                        }
                  ]

        @count.times {|x|
          (StringStubber.stub_words(@text, x) !~ /\s+$/).should be_true
        }
      end
    end # describe 'Method: stub_words'

  end
end