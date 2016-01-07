require 'rails_helper'

RSpec.describe "hangman_states/index", type: :view do
  before(:each) do
    assign(:hangman_states, [
      HangmanState.create!(word_to_guess: "word", number_of_lives: 5, player: Player.create!(name: "Jordane")),
      HangmanState.create!(word_to_guess: "anotherword", number_of_lives: 8, player: Player.create!(name: "Player"))
    ])
  end

  it "renders a list of hangman_states" do
    render
  end
end
