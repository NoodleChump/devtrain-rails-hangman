require 'rails_helper'

RSpec.describe "HangmanGames", type: :request do
  describe "GET /hangman_games" do
    it "works! (now write some real specs)" do
      get hangman_games_path
      expect(response).to have_http_status(200)
    end
  end
end
