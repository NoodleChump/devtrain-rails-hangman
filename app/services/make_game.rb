class MakeGame
  def initialize(user: nil, ranked: true, word_to_guess: nil, number_of_lives: Game::DEFAULT_NUMBER_OF_LIVES)
    @user = user || current_user
    @ranked = ranked
    @word_to_guess = word_to_guess.blank? ? GenerateRandomWord.new.call : word_to_guess
    @word_to_guess.downcase!
    @number_of_lives = number_of_lives
  end

  def call
    @game = @user.games.create(custom: !@ranked, word_to_guess: @word_to_guess, number_of_lives: @number_of_lives)
  end
end
