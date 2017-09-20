class UrlGenerator
  ALPHABET = (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).shuffle.freeze
  SHORT_LINK_LENGTH = 5.freeze

  def self.call
    link = []
    SHORT_LINK_LENGTH.times { link << ALPHABET.sample }
    link.join
  end
end