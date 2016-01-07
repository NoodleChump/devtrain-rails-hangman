require 'rails_helper'

RSpec.describe "hangman_states/index", type: :view do
  before(:each) do
    assign(:hangman_states, [
      HangmanState.create!(),
      HangmanState.create!()
    ])
  end

  it "renders a list of hangman_states" do
    render
  end
end
