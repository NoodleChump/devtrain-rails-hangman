require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:letter) { "a" }
  let(:state) { HangmanState.create(word_to_guess: "word", number_of_lives: 5) }
  subject(:guess) { Guess.new(letter: letter, hangman_state: state) }

  context "when creating a new guess" do
    let(:letter) { "" }
    it { is_expected.to_not be_valid }
  end

  context "doesn't validate a guess with a letter that isn't in the alphabet" do
    let(:letter) { "!" }
    it { is_expected.to_not be_valid }
  end

  context "doesn't validate a guess when the letter is more than a single character" do
    let(:letter) { "abc" }
    it { is_expected.to_not be_valid }
  end

  context "validates a guess with a letter that is in the alphabet" do
    let(:letter) { "a" }
    it { is_expected.to be_valid }
  end

=begin
    it "doesn't validate when a guess for the same letter has already been made" do
      state = HangmanState.new
      state.word_to_guess = "word"
      state.number_of_lives = 5
      state.save
      #TODO finish
      #HangmanSpecHelper.make_guess("a")
      #HangmanSpecHelper.make_guess("a")
    end
=end
end
