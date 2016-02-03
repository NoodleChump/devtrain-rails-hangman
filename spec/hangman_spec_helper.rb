module HangmanSpecHelper
  def self.make_guesses(game, letters)
    letters.split(//).each { |letter| MakeGuess.new(game, letter).call }
  end
end
