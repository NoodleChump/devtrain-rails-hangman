FactoryGirl.define do
  factory :game, aliases: [:ranked_game] do
    player
    word_to_guess "hangman"
    number_of_lives { Game::DEFAULT_NUMBER_OF_LIVES }
    custom_word false
  end

  factory :custom_game, class: Game do
    player
    word_to_guess "hangman"
    number_of_lives 5
    custom_word true
  end
end
