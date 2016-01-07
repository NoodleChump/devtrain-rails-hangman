require 'rails_helper'

RSpec.describe "hangman_states/show", type: :view do
  before(:each) do
    @hangman_state = assign(:hangman_state, HangmanState.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
