require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(word_to_guess: "word", number_of_lives: 5, player: Player.create!(name: "Jordane")),
      Game.create!(word_to_guess: "anotherword", number_of_lives: 8, player: Player.create!(name: "Player"))
    ])
  end

  it "renders a list of games" do
    render
  end
end
