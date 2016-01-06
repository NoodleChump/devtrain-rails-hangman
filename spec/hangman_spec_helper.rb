module HangmanSpecHelper
  def self.make_guess(state, letter)
    state.guesses.create!(letter: letter)
  end

  def self.make_guesses(state, letters)
    letters.split(//).each { |letter| make_guess(state, letter) }
  end
end
