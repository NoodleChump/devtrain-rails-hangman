require 'rails_helper'

RSpec.describe "hangman_games/new", type: :view do
  before(:each) do
    assign(:hangman_game, HangmanGame.new())
  end

  it "renders new hangman_game form" do
    render

    assert_select "form[action=?][method=?]", hangman_games_path, "post" do
    end
  end
end
