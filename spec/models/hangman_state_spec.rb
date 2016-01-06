require 'rails_helper'

RSpec.describe HangmanState, type: :model do

  def make_guess(state, letter)
    guess = Guess.new
    guess.hangman_state = state
    guess.letter = letter
    guess.save
  end

  context "when creating a new hangman state" do
    let(:state) { HangmanState.new }

    it "doesn't validate a blank HangmanState" do
      expect(state.valid?).to eq false
    end

    it "doesn't validate a HangmanState with an invalid number of lives" do
      state.word_to_guess = "word"
      state.number_of_lives = -1
      expect(state.valid?).to eq false
    end

    it "doesn't validate a HangmanState with an invalid word" do
      state.word_to_guess = ""
      state.number_of_lives = 1
      expect(state.valid?).to eq false
    end

    it "validates a HangmanState with a valid word and number of lives" do
      state = HangmanState.new
      state.word_to_guess = "word"
      state.number_of_lives = 5
      expect(state.valid?).to eq true
    end
  end

  context "when a valid HangmanState is created" do
    let(:state) { HangmanState.new }

    before do
      state.word_to_guess = "word"
      state.number_of_lives = 5
    end

    it "has no guessed letters" do
      expect(state.guesses.length).to eq 0
    end

    it "isn't won" do
      expect(state.won?).to eq false
    end

    it "isn't lost" do
      expect(state.lost?).to eq false
    end

    it "isn't game over" do
      expect(state.game_over?).to eq false
    end
  end

  context "when the state runs out of guesses, the game is lost" do
    let(:state) { HangmanState.new }

    before do
      state.word_to_guess = "word"
      state.number_of_lives = 1
      make_guess(state, "z")
    end

    it "is lost" do
      expect(state.lost?).to eq true
    end

    it "isn't won" do
      expect(state.won?).to eq false
    end

    it "is game over" do
      expect(state.game_over?).to eq true
    end
  end
end
