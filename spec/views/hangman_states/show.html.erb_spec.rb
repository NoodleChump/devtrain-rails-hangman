require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, GamePresenter.new(Game.create!(word_to_guess: "word", number_of_lives: 5, player: Player.create!(name: "Jordane"))))
    @guess = assign(:guess, GamePresenter.new(Guess.create!(letter: 'a', game: @game)))
  end

  it "renders attributes in <p>" do
    render
  end
end
