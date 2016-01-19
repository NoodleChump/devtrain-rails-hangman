require 'rails_helper'

RSpec.describe GamePresenter, type: :presenter do
  let(:player) { Player.create!(name: "Player") }
  let(:word) { "word" }
  let(:lives) { 5 }
  let(:game) { Game.create!(word_to_guess: word, number_of_lives: lives, player: player) }
  let(:letters_to_guess) { "" }

  subject(:presented_game) { present game }

  before do
    HangmanSpecHelper.make_guesses(game, letters_to_guess)
  end

  context "when a new game is started without any guesses" do
    it "has a completely censored word" do
      expect(presented_game.censored_word).to eq GamePresenter::CENSOR_CHARACTER * word.length
    end

    it "has a progress of 0(%)" do
      expect(presented_game.progression_percentage). to eq 0.0
    end

    it "has a status of not started" do
      expect(presented_game.progression).to eq :not_started
    end
  end

  context "when a game has some guesses made" do
    let(:lives) { 4 }
    let(:letters_to_guess) { word[0..-2] + "zx" }

    it "has a partially censored word" do
      expect(presented_game.censored_word).to eq word[0..-2] + GamePresenter::CENSOR_CHARACTER
    end

    it "has a progress of 50(%)" do
      expect(presented_game.progression_percentage). to eq 50.0
    end

    it "has a status of in progress" do
      expect(presented_game.progression).to eq :in_progress
    end
  end

  context "when a game has all of its letters guessed without mistake" do
    let(:letters_to_guess) { word }

    it "has a completely uncesored word" do
      expect(presented_game.censored_word).to eq word
    end

    it "has a progress of 0(%) (No incorrect guesses)" do
      expect(presented_game.progression_percentage). to eq 0.0
    end

    it "has a status of won" do
      expect(presented_game.progression).to eq :won
    end
  end

  context "when the game runs out of guesses" do
    let(:letters_to_guess) { "z" }
    let(:lives) { 1 }

    it "has a status of lost" do
      expect(presented_game.progression).to eq :lost
    end

    it "has a progress of 100(%)" do
      expect(presented_game.progression_percentage). to eq 100.0
    end
  end
end
