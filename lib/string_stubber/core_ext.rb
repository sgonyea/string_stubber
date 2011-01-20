module StringStubber
  module CoreExt
    include StringStubber::Base

    def scanner
      @scanner ||= StringScanner.new(self)
    end

    def stub_words(max_words, save_pos=false)
      scanner.reset unless save_pos

      scan_words(scanner, max_words)
    end
    alias :stub :stub_words

    def stub_at_most(max_chars, save_pos=true)
      scanner.reset unless save_pos

      scan_text(scanner, max_chars)
    end
    alias :stub_text  :stub_at_most
    alias :stub_chars :stub_at_most
    alias :stub_pos   :stub_at_most
    alias :stub_to    :stub_at_most

    def stub_at_least(min_chars, save_pos=true)
      scanner.reset unless save_pos

      scan_text(scanner, min_chars) << scan_word(scanner).to_s
    end
    alias :stub_thru    :stub_at_least
    alias :stub_through :stub_at_least

  end
end

class String
  include StringStubber::CoreExt
end
