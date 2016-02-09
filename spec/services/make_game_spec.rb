require 'rails_helper'

RSpec.describe MakeGuess, type: :service do
  let(:user) { create(:user) }

  context "when making a call to make a game with only a user" do
    subject(:game) { MakeGame.new(user: user).call }

    it "makes a game with the default number of lives" do
      expect(game.initial_number_of_lives).to eq Game::DEFAULT_NUMBER_OF_LIVES
    end

    it "chooses a random word to guess" do
      guesses = Hash.new(false)
      20.times do
        guess = MakeGame.new(user: user).call
        expect(guess.word_to_guess).to be_present
        expect(guesses[guess.word_to_guess]).to eq false
        guesses[guess.word_to_guess] = true
      end
    end

    it "has the given user as the player" do
      expect(game.user).to eq user
    end

    it { is_expected.to be_ranked }
  end

  context "when making a call to make a game specifying named params" do
    let(:word) { "banana" }
    let(:lives) { 3 }
    let(:ranked) { true }

    subject(:game) { MakeGame.new(
      user:                     user,
      word_to_guess:            word,
      initial_number_of_lives:  lives,
      ranked:                   ranked
    ).call }

    #custom word and lives should override given ranked param
    it { is_expected.to_not be_ranked }

    it "has the custom word to guess" do
      expect(game.word_to_guess).to eq word
    end

    it "has the custom number of lives" do
      expect(game.initial_number_of_lives).to eq lives
    end

    it "has the given user as the player" do
      expect(game.user).to eq user
    end
  end
end
