require 'rails_helper'

RSpec.describe "hangman_games/index", type: :view do
  before(:each) do
    assign(:hangman_games, [
      HangmanGame.create!(),
      HangmanGame.create!()
    ])
  end

  it "renders a list of hangman_games" do
    render
  end
end
