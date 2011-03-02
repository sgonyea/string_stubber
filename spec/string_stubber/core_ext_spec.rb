require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Stubber::CoreExt do
  describe 'The CoreExt module should be mixed into String (via stubber.rb)' do
    before :each do
      @methods = [ :scanner, :stub_words, :stub_at_most, :stub_at_least ]
    end

    it 'should have class methods available' do
      text = "it 'should have class methods available' <-- OMG META"

      @methods.each do |method|
        text.respond_to?(method).should be_true
      end
    end
  end # Should be mixed into String

  describe 'The stubbing methods should behave as documented' do
    before :each do
      @text   = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. "
      @count  = @text.split(/\W+/).count
    end

    it 'should return a StringScanner instance, when calling String#scanner' do
      @text.scanner.should be_instance_of(StringScanner)
    end

    it 'should act upon the String instance, itself' do
      @text.scanner.string.should == @text
    end

    describe 'Method: stub_words' do
      it 'should retain its position' do
        @text.stub_words(1)
        @text.scanner.pos.should be(5)
      end

      it 'should always return a string' do
        @text.stub_words( -100).should be_instance_of(String)
        @text.stub_words(  -10).should be_instance_of(String)
        @text.stub_words(    0).should be_instance_of(String)
        @text.stub_words(   10).should be_instance_of(String)
        @text.stub_words(  100).should be_instance_of(String)
      end

      it 'should correctly act on negative offsets' do
        @text.stub_words( -1).should       eql("placerat. ")
        @text.stub_words(-10).should       eql("consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. ")
        @text.stub_words( -1, true).should eql("amet, ")
      end

      it 'should never have trailing spaces'
      it 'should return the expected number of words'
    end

    describe 'Method: stub_at_most' do
      it 'should retain its position, relative to what was returned' do
        @text.stub_at_most(3)
        @text.scanner.pos.should be(0)

        @text.stub_at_most(5)
        @text.scanner.pos.should be(5)
      end

      it 'should always return a string' do
        @text.stub_at_most( -100).should be_instance_of(String)
        @text.stub_at_most(  -10).should be_instance_of(String)
        @text.stub_at_most(    0).should be_instance_of(String)
        @text.stub_at_most(   10).should be_instance_of(String)
        @text.stub_at_most(  100).should be_instance_of(String)
      end

      it 'should correctly act on negative offsets' do
      end
      it 'should never have trailing spaces'
    end

    describe 'Method: stub_at_least' do
      it 'should retain its position' do
        @text.stub_at_least(3)
        @text.scanner.pos.should be(5)

        @text.stub_at_least(5)
        @text.scanner.pos.should be(5)

        @text.stub_at_least(6)
        @text.scanner.pos.should be(11)

        @text.stub_at_least(3)
        @text.scanner.pos.should be(5)

        @text.stub_at_least(4, true)
        @text.scanner.pos.should be(11)
      end

      it 'should always return a string' do
        @text.stub_at_least( -100).should be_instance_of(String)
        @text.stub_at_least(  -10).should be_instance_of(String)
        @text.stub_at_least(    0).should be_instance_of(String)
        @text.stub_at_least(   10).should be_instance_of(String)
        @text.stub_at_least(  100).should be_instance_of(String)
      end

      it 'should correctly act on negative offsets' do
      end
      it 'should never have trailing spaces'
    end
  end # Docs check
end
