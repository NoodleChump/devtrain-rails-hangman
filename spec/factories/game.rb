FactoryGirl.define do
  factory :game, aliases: [:ranked_game] do
    word_to_guess "hangman"
    number_of_lives { Game::DEFAULT_NUMBER_OF_LIVES }
    custom_word false
    association :user, factory: :user
  end

  factory :custom_game, class: Game do
    word_to_guess "hangman"
    number_of_lives 5
    custom_word true
    association :user, factory: :user
  end
end
