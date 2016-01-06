require 'rails_helper'

RSpec.describe HangmanState, type: :model do

  let(:word) { "word" }
  let(:initial_lives) { 5 }
  let(:guesses_made) { "" }

  subject(:state) { HangmanState.create(word_to_guess: word, number_of_lives: initial_lives) }

  before do
    HangmanSpecHelper.make_guesses(state, guesses_made)
  end

  context "when creating a new hangman state with invalid intial lives" do
    let(:initial_lives) { -1 }
    it { is_expected.to_not be_valid }
  end

  #FIXME contexts need separating and cleaning up
  context "when creating a new hangman state with and invalid word" do
    let(:word) { "" }
    it "doesn't validate a HangmanState with an invalid word" do
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
    let(:initial_lives) { 5 }

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

  context "when the state runs out of guesses" do
    let(:guesses_made) { "z" }
    let(:initial_lives) { 1 }

    it { is_expected.to be_lost }
    it { is_expected.to_not be_won }
    it { is_expected.to be_game_over }

    it "has no more guesses left" do
      expect(state.number_of_guesses_remaining).to eq 0
    end

    it "has the guessed letter stored correctly" do
      expect(state.guessed_letters.include?("z")).to eq true
    end
  end

  context "when all the letters in the word to guess are guessed" do
    let(:guesses_made) { "word" }

    it { is_expected.to_not be_lost }
    it { is_expected.to be_won }
    it { is_expected.to be_game_over }

    it "has guesses left" do
      expect(state.number_of_guesses_remaining).to be > 0
    end

    it "has each of the guessed letters stored correctly" do
      expect(guesses_made.chars.all? { |letter| state.guessed_letters.include?(letter) }).to eq true
    end
  end
end
