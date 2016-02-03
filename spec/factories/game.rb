FactoryGirl.define do
  factory :game, aliases: [:ranked_game] do
    word_to_guess "hangman"
    number_of_lives { Game::DEFAULT_NUMBER_OF_LIVES }
    custom_word false
    user factory: :user, strategy: :build
  end

  factory :custom_game, class: Game do
    word_to_guess "hangman"
    number_of_lives 5
    custom_word true
    user factory: :user, strategy: :build
  end
end
