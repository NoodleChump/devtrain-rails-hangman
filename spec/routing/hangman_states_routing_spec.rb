require "rails_helper"

RSpec.describe HangmanStatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hangman_states").to route_to("hangman_states#index")
    end

    it "routes to #new" do
      expect(:get => "/hangman_states/new").to route_to("hangman_states#new")
    end

    it "routes to #show" do
      expect(:get => "/hangman_states/1").to route_to("hangman_states#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/hangman_states/1/edit").to route_to("hangman_states#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/hangman_states").to route_to("hangman_states#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/hangman_states/1").to route_to("hangman_states#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/hangman_states/1").to route_to("hangman_states#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hangman_states/1").to route_to("hangman_states#destroy", :id => "1")
    end

  end
end
