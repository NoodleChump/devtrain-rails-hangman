require 'rails_helper'

RSpec.describe "games/edit", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(word_to_guess: "word", number_of_lives: 5, user: User.create!(name: "Jordane", email: "user@user.com", password: "foobar", password_confirmation: "foobar")))
  end

  it "renders the edit game form" do
    render

    assert_select "form[action=?][method=?]", game_path(@game), "post" do
    end
  end
end
