module HangmanSpecHelper
  def self.make_guess(game, letter)
    game.save!
    game.guesses.create!(letter: letter)
  end

  def self.make_guesses(game, letters)
    letters.split(//).each { |letter| make_guess(game, letter) }
  end
end
