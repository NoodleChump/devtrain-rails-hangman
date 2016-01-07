require 'rails_helper'

RSpec.describe "hangman_games/show", type: :view do
  before(:each) do
    @hangman_game = assign(:hangman_game, HangmanGame.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
