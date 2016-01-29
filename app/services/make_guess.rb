class MakeGuess
  def initialize(guess) #TODO pass the game and letter instead, make the guess?
    @guess = guess
  end

  def call
    @guess.game.lock!
    if already_guessed?
      @guess.errors.add(:letter, "has already been guessed")
      false
    else
      @guess.save
    end
    @guess.game.save!
  end

  private

  def already_guessed?
    @guess.game.guesses.pluck(:letter).include?(@guess.letter)
  end
end
