module StringStubber
  module Base
    WORD = /[\w[:punct:]]+/
    SNIP = /\s+$/

    # Stubs a given text string, up to a given number of words
    #   @param [String] text      Any piece of text
    #   @param [Fixnum] max_words The desired number of words
    #   @return [String] The text, stubbed at max_words number of words
    def stub_words(text, max_words)
      scanner = StringScanner.new(text.to_s)

      return scan_words(scanner, max_words)
    end

    # Stubs the given text string a number of whole-words, not to go beyond the given text position
    #   @param [String] text      Any piece of text
    #   @param [Fixnum] max_text  Text position that delimits the desired number of whole words
    #   @return [String] The text, stubbed at the max_text position
    def stub_text(text, max_text)
      scanner = StringScanner.new(text.to_s)

      return scan_text(scanner, max_text)
    end

    def scan_word(scanner)
      scanner.scan_until(WORD)
    end

    def scan_words(scanner, max_words)
      max_words.times.map {
        scanner.scan_until(WORD)
      }.compact.join
    end

    def scan_text(scanner, max_text)
      start = scanner.pos

      until scanner.pos >= max_text || scanner.scan_until(WORD).nil?; end

      (str = scanner.pre_match || scanner.string[start, max_text]).gsub!(SNIP, '')
    end
  end # module Base
end # module StringStubber
