require 'stubber/version'

module Stubber
  autoload :CoreExt, 'stubber/core_ext'

  module Base
    WORD = /\w+[\!\.\?]*[^\s,]/

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

    # Scans ahead one word position, and returns it
    #   @param [StringScanner] scanner
    #   @return [String]
    def scan_word(scanner)
      scanner.scan_until(WORD)
    end

    # Scans a given number of words from a scanner
    #   @param [StringScanner]
    #   @param [Fixnum]
    #   @return [String]
    def scan_words(scanner, max_words)
      words = max_words.times.map {
                scan_word(scanner)
              }
      words.compact!
      words.join
    end

    # Scans a given number of words, up to a given character position (but not beyond)
    #   @param [StringScanner]
    #   @param [Fixnum]
    #   @return [String]
    def scan_text(scanner, max_text)
      start = scanner.pos

      until scanner.pos >= (max_text + start) || scan_word(scanner).nil?; end

      (scanner.pre_match || scanner.string[start, max_text]).to_s
    end
  end # module Base
end # module Stubber
