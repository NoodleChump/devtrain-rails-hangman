class MakeGuess
  def initialize(guess) #TODO pass the game and letter instead, and build the guess?
    @guess = guess
  end

  def call
    result = false
    @guess.game.lock!
    if already_guessed?
      @guess.errors.add(:letter, "has already been guessed")
    else
      result = @guess.save
    end
    @guess.game.save!
    result
  end

  private

  def already_guessed?
    @guess.game.guesses.pluck(:letter).include?(@guess.letter)
  end
end
