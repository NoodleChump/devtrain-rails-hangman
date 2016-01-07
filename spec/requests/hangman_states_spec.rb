require 'rails_helper'

RSpec.describe "HangmanStates", type: :request do
  describe "GET /hangman_states" do
    it "works! (now write some real specs)" do
      get hangman_states_path
      expect(response).to have_http_status(200)
    end
  end
end
