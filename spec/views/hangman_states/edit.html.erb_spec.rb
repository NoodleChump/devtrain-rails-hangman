require 'rails_helper'

RSpec.describe "hangman_states/edit", type: :view do
  before(:each) do
    @hangman_state = assign(:hangman_state, HangmanState.create!())
  end

  it "renders the edit hangman_state form" do
    render

    assert_select "form[action=?][method=?]", hangman_state_path(@hangman_state), "post" do
    end
  end
end
