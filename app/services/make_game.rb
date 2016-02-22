class MakeGame
  def initialize(user: nil, ranked: true, word_to_guess: nil, initial_number_of_lives: Game::DEFAULT_NUMBER_OF_LIVES, sender: nil)
    @user = user
    @word_to_guess = word_to_guess
    @initial_number_of_lives = initial_number_of_lives
    @custom = !ranked || is_custom?
    @sender = sender
  end

  def call
    @game = @user.games.create(
      custom:                   @custom,
      word_to_guess:            word_to_guess.downcase,
      initial_number_of_lives:  @initial_number_of_lives,
      sender:                   @sender
    )

    MakeNewGameNotification.new(
      from: @sender,
      to:   @user,
      game: @game
    ).call if @user != @sender && @sender

    @game
  end

  private

  def is_custom?
    @word_to_guess.present? || @initial_number_of_lives != Game::DEFAULT_NUMBER_OF_LIVES
  end

  def word_to_guess
    if @word_to_guess.blank?
      GenerateRandomWord.new.call
    else
      @word_to_guess
    end
  end
end
