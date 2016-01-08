module HangmanStatesHelper
  WORDS_FILE = 'app/assets/words.txt'

  def self.random_word
    words = File.readlines(WORDS_FILE)
    words.map(&:strip).sample
  end
end
