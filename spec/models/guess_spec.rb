require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:letter) { "a" }
  let(:state) { HangmanState.create(word_to_guess: "word", number_of_lives: 5) }
  subject(:guess) { Guess.new(letter: letter, hangman_state: state) }

  context "when creating a new guess" do
    let(:letter) { "" }
    it { is_expected.to_not be_valid }
  end

  context "when making a guess with a letter that isn't in the alphabet" do
    let(:letter) { "!" }
    it { is_expected.to_not be_valid }
  end

  context "when making a guess with a word instead of a letter" do
    let(:letter) { "abc" }
    it { is_expected.to_not be_valid }
  end

  context "when making a unique guess" do
    let(:letter) { "a" }
    it { is_expected.to be_valid }
  end

  context "when making a non-unique guess" do
    before do
      HangmanSpecHelper.make_guess(state, letter)
    end

    it "shouldn't validate when a guess for the same letter has already been made" do
      guess = state.guesses.create(letter: letter)
      expect(guess).to_not be_valid
    end

    it "shouldn't save and the number of guesses taken is not affected" do
      expect(state.guesses.build(letter: letter).save).to eq false
      state.guesses.reload
      expect(state.guesses.length).to eq 1
    end
  end
end
