require 'rails_helper'

RSpec.describe "hangman_states/new", type: :view do
  before(:each) do
    assign(:hangman_state, HangmanState.new())
  end

  it "renders new hangman_state form" do
    render

    assert_select "form[action=?][method=?]", hangman_states_path, "post" do
    end
  end
end
