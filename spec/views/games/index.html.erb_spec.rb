require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(word_to_guess: "word", number_of_lives: 5, user: User.create!(name: "Jordane", email: "user@user.com")),
      Game.create!(word_to_guess: "anotherword", number_of_lives: 8, user: User.create!(name: "User", email: "another@user.com"))
    ])
  end

  it "renders a list of games" do
    render
  end
end
