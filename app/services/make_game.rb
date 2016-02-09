class MakeGame
  #TODO Make specs
  def initialize(user: nil, ranked: true, word_to_guess: nil, initial_number_of_lives: Game::DEFAULT_NUMBER_OF_LIVES)
    @user = user
    @ranked = ranked
    @word_to_guess = word_to_guess.blank? ? GenerateRandomWord.new.call : word_to_guess
    @initial_number_of_lives = initial_number_of_lives
  end

  def call
    @game = @user.games.create(
      custom:           !@ranked,
      word_to_guess:    @word_to_guess.downcase,
      initial_number_of_lives:  @initial_number_of_lives
    )
  end
end
