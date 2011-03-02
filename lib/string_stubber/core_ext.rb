require 'string_stubber/base'

module StringStubber
  module CoreExt
    include StringStubber::Base

    # @return [StringScanner]
    def scanner
      @scanner ||= StringScanner.new(self)
    end

    #   @param [Fixnum]
    #   @param [true, false]
    #   @return [String]
    def stub_words(max_words, save_pos=false)
      scanner.reset unless save_pos

      if max_words < 0
        rev_stub_words(max_words.abs, save_pos)
      else
        scan_words(scanner, max_words)
      end
    end
    alias :stub   :stub_words
    alias :words  :stub_words

    #   @param [Fixnum]
    #   @param [true, false]
    #   @return [String]
    def stub_at_most(max_chars, save_pos=false)
      scanner.reset unless save_pos

      str = if max_chars < 0
              rev_stub_at_most(max_chars.abs, save_pos)
            else
              scan_text(scanner, max_chars)
            end

      begin
        scanner.unscan if str.empty? && scanner.pos > max_chars && !scanner.pre_match.nil?
      rescue StringScanner::Error => e
        # Do nothing
      end

      return str
    end
    alias :stub_text  :stub_at_most
    alias :stub_chars :stub_at_most
    alias :stub_pos   :stub_at_most
    alias :stub_to    :stub_at_most

    #   @param [Fixnum]
    #   @param [true, false]
    #   @return [String]
    def stub_at_least(min_chars, save_pos=false)
      scanner.reset unless save_pos

      if min_chars < 0
        return rev_stub_at_least(min_chars.abs, save_pos)
      end

      start = scanner.pos
      str   = scan_text(scanner, min_chars)

      if(str.size < (min_chars + start))
        str << scanner.matched.to_s
      end

      str
    end
    alias :stub_thru    :stub_at_least
    alias :stub_through :stub_at_least

  private
    #   @param [Fixnum]
    #   @param [true, false]
    #   @return [String]
    def rev_stub_words(max_words, save_pos=false)
      str = self.reverse
      str.scanner.pos = 0 - scanner.pos if save_pos

      stub = str.stub_words(max_words, save_pos).reverse!
      scanner.pos = 0 - str.scanner.pos
      return stub
    end

    #   @param [Fixnum]
    #   @param [true, false]
    #   @return [String]
    def rev_stub_at_most(max_chars, save_pos=false)
      str = self.reverse
      str.scanner.pos = 0 - scanner.pos if save_pos

      stub = str.stub_at_most(max_chars, save_pos).reverse!
      scanner.pos = 0 - str.scanner.pos
      return stub
    end

    #   @param [Fixnum]
    #   @param [true, false]
    #   @return [String]
    def rev_stub_at_least(min_chars, save_pos=false)
      str = self.reverse
      str.scanner.pos = 0 - scanner.pos if save_pos

      stub = str.stub_at_least(min_chars, save_pos).reverse!
      scanner.pos = 0 - str.scanner.pos
      return stub
    end
  end
end
