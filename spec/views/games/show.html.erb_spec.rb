require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, create(:game))
    @guess = assign(:guess, create(:guess, game: @game))
  end

  it "renders attributes in <p>" do
    render
  end
end
