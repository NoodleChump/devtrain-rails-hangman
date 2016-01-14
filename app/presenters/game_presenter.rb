class GamePresenter < BasicObject
  CENSOR_CHARACTER = "*"

  def initialize(game)
    @game = game
  end

  def _h
    @game
  end

  def censored_word
    @game.censored_word.map { |item| item != nil ? item : CENSOR_CHARACTER }.join
  end

  private

  def method_missing(method, *arguments, &block)
    @game.send(method, *arguments, &block)
  end
end
