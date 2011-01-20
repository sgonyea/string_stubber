module StringStubber
  module Base
    WORD = /\b(\w+)\b/
    SNIP = /\s*?\W+$/

    def stub_words(text, max_words)
      scanner = StringScanner.new(text.to_s)

      return scan_words(scanner, max_words)
    end

    def stub_text(text, max_text)
      string  = text.to_s
      scanner = StringScanner.new(string)

      return scan_text(scanner, max_text)
    end

    def scan_word(scanner)
      (str = scanner.scan_until(WORD)).gsub!(SNIP, '')

      return str
    end

    def scan_words(scanner, max_words)
      max_words.times.map {
        scanner.scan_until(WORD)
      }.flatten.join
    end

    def scan_text(scanner, max_text)
      start = scanner.pos

      until scanner.pos > max_text || scanner.scan_until(WORD).nil?; end
      
      (str = scanner.pre_match || scanner.string[start, max_text]).gsub!(SNIP, '')

      return str
    end
  end # module Base
end # module StringStubber
