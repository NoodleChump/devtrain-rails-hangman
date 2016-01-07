require 'rails_helper'

RSpec.describe "players/index", type: :view do
  before(:each) do
    assign(:players, [
      Player.create!(name: "Player 1"),
      Player.create!(name: "Player 2")
    ])
  end

  it "renders a list of players" do
    render
  end
end
