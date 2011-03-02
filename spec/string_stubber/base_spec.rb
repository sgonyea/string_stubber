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

  describe 'The stubbing methods should behave as documented' do
    before :each do
      @text =  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. "
      @text << "Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi "
      @text << "blandit mollis magna. Suspendisse eu tortor. Donec vitae felis nec ligula blandit rhoncus. Ut a pede ac neque "
      @text << "mattis facilisis. Nulla nunc ipsum, sodales vitae, hendrerit non, imperdiet ac, ante. Morbi sit amet mi. Ut "
      @text << "magna. Curabitur id est. Nulla velit. Sed consectetuer sodales justo. Aliquam dictum gravida libero. Sed eu "
      @text << "turpis. Nunc id lorem. Aenean consequat tempor mi. Phasellus in neque. Nunc fermentum convallis ligula."

      @count = @text.split(/\W+/).count
    end

    describe 'Methods: stub_words, scan_words' do
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
        # regex   = /[^\w\s]/
        # scanner = StringScanner.new(@text)
        # count   = @text.split(/[^\w\s]/).count
        # puncts  = Hash[ count.times.map {
        #                   scanner.scan_until(regex)
        #                   [scanner.pre_match.split.count, scanner.pos - 1]
        #                 }
        #           ]
        # 
        # @count.times {|x|
        #   (StringStubber.stub_words(@text, x) !~ /\s+$/).should be_true
        # }
      end

      #
    end # describe 'Method: stub_words'

    describe 'Methods: stub_text, scan_text' do
      it 'should return fewer chars than specified, if the offset is in the middle of a word' do
        StringStubber.stub_text(@text, 33).size.should be(28)
      end

      it 'should return the same number of chars specified, if the offset lands on a punctuation character' do
        # This is a tough nut to crack. Eesh.
        StringStubber.stub_text(@text, 27).should       == "Lorem ipsum dolor sit amet, "
        StringStubber.stub_text(@text, 27).size.should  be(28)
      end

      it 'should return fewer chars than specified, if the position lands in white-space' do
        (StringStubber.stub_text(@text, 28).size == 28).should be_true
      end

      it 'should return the whole string, if the ammt of text exceeds the amount of actual text' do
        StringStubber.stub_text(@text, 2000).casecmp(@text).should be(0)
      end

      it 'should return a copy of the whole string, if the ammt of text exceeds the amount of actual text' do
        (StringStubber.stub_text(@text, 2000).object_id != @text.object_id).should be_true
      end

      it 'should always return a string' do
        stubs = [
          StringStubber.stub_text(@text,  -2000),
          StringStubber.stub_text(@text,     -1),
          StringStubber.stub_text(@text,      0),
          StringStubber.stub_text(@text,     10),
          StringStubber.stub_text(@text,   2000)
        ]

        stubs.each {|stub|
          stub.is_a?(String).should be_true
        }
      end
    end # describe 'Method: stub_text'

    describe 'Methods: scan_word' do
      before :each do
        #             #1   #2    #3   #4  #5       #6            #7      #8
        @words = %w[Lorem ipsum dolor sit amet consectetuer adipiscing elit.]
        @wjoin = @words.join(' ')
      end

      it 'should scan ahead exactly one word' do
        ss = StringScanner.new(@wjoin)

        x = 0
        until StringStubber.scan_word(ss).nil?
          x += 1
        end

        x.should be(@words.count)
      end

      it 'should return the correct word' do
        ss = StringScanner.new(@wjoin)
        @words.each do |word|
          StringStubber.scan_word(ss).strip.should == word
        end
      end

      it 'scan_word should return a string, unless there is no more to scan' do
        ss  = StringScanner.new(@wjoin)
        x   = 0

        until (word = StringStubber.scan_word(ss)).nil?
          word.should be_instance_of(String)
        end

        word.should be_nil
      end
    end
  end
end