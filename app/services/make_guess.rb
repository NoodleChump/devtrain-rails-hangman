class MakeGuess
  def initialize(game, letter)
    @game = game
    @letter = letter
    @guess = @game.guesses.build(letter: @letter)
  end

  def call
    @game.lock!
    @guess.save if !already_guessed?
    # An already guessed guess (letter) is made in memory, but NOT PERSISTED
    @game.save!

    @guess
  end

  private

  def already_guessed?
    if @game.guesses.pluck(:letter).include?(@guess.letter)
      @guess.errors.add(:letter, "has already been guessed")
      true
    else
      false
    end
  end
end
