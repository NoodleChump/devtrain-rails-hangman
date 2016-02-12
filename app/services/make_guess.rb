class MakeGuess
  def initialize(game, letter)
    @game = game
    @letter = letter
    @guess = @game.guesses.build(letter: @letter)
  end

  def call
    @game.lock!
    valid = !already_guessed? ? @guess.save : false
    @game.save!

    MakeCompletedGameNotification.new(
      to:   @game.sender,
      from: @game.user,
      game: @game
    ).call if valid && @game.sender && @game.game_over? && @game.sender != @game.user

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
