require 'game'

class GamePresenter < BasicObject
  CENSOR_CHARACTER = "*"

  def initialize(game)
    @game = game
  end

  def censored_word
    @game.censored_word.map { |item| item != nil ? item : CENSOR_CHARACTER }.join
  end

  def number_of_blanks_remaining
    censored_word.count(nil)
  end

  def progression_percentage
    lost? ? 100.0 : (number_of_incorrect_guesses / number_of_lives.to_f) * 100
  end

  def _h
    @game
  end

  private

  def number_of_incorrect_guesses
    incorrect_guesses.length
  end

  def method_missing(method, *arguments, &block)
    @game.send(method, *arguments, &block)
  end
end
