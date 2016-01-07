require "rails_helper"

RSpec.describe HangmanGamesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hangman_games").to route_to("hangman_games#index")
    end

    it "routes to #new" do
      expect(:get => "/hangman_games/new").to route_to("hangman_games#new")
    end

    it "routes to #show" do
      expect(:get => "/hangman_games/1").to route_to("hangman_games#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/hangman_games/1/edit").to route_to("hangman_games#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/hangman_games").to route_to("hangman_games#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/hangman_games/1").to route_to("hangman_games#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/hangman_games/1").to route_to("hangman_games#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hangman_games/1").to route_to("hangman_games#destroy", :id => "1")
    end

  end
end
