module StringStubber
  module CoreExt
    include StringStubber::Base

    def scanner
      @scanner ||= StringScanner.new(self)
    end

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

    def stub_at_most(max_chars, save_pos=true)
      scanner.reset unless save_pos

      if max_chars < 0
        rev_stub_at_most(max_chars.abs, save_pos)
      else
        scan_text(scanner, max_chars)
      end
    end
    alias :stub_text  :stub_at_most
    alias :stub_chars :stub_at_most
    alias :stub_pos   :stub_at_most
    alias :stub_to    :stub_at_most

    def stub_at_least(min_chars, save_pos=true)
      scanner.reset unless save_pos

      if min_chars < 0
        rev_stub_at_least(min_chars.abs, save_pos)
      else
        scan_text(scanner, min_chars) << scan_word(scanner).to_s
      end
    end
    alias :stub_thru    :stub_at_least
    alias :stub_through :stub_at_least


  private
    def rev_stub_words(max_words, save_pos=false)
      str = self.reverse
      str.scanner.pos = 0 - scanner.pos if save_pos

      return str.stub_words(max_words, save_pos).reverse!
    end

    def rev_stub_at_most(max_chars, save_pos=true)
      str = self.reverse
      str.scanner.pos = 0 - scanner.pos if save_pos

      return str.stub_at_most(max_chars, save_pos).reverse!
    end

    def rev_stub_at_least(min_chars, save_pos=true)
      str = self.reverse
      str.scanner.pos = 0 - scanner.pos if save_pos

      return str.stub_at_least(min_chars, save_pos).reverse!
    end
  end
end

class String
  include StringStubber::CoreExt
end
