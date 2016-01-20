require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(word_to_guess: "word", number_of_lives: 5, user: User.create!(name: "Jordane")))
    @guess = assign(:guess, Guess.create!(letter: 'a', game: @game))
  end

  it "renders attributes in <p>" do
    render
  end
end
