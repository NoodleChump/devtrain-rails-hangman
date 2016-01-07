require 'rails_helper'

RSpec.describe "hangman_games/edit", type: :view do
  before(:each) do
    @hangman_game = assign(:hangman_game, HangmanGame.create!())
  end

  it "renders the edit hangman_game form" do
    render

    assert_select "form[action=?][method=?]", hangman_game_path(@hangman_game), "post" do
    end
  end
end
