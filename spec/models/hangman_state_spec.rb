require 'rails_helper'

RSpec.describe HangmanState, type: :model do

  let(:word) { "word" }
  let(:lives) { 5 }
  let(:letters_to_guess) { "" }
  let(:player) { Player.create!(name: "Jordane") }

  subject(:state) { HangmanState.create(word_to_guess: word, number_of_lives: lives, player: player) }

  before do
    HangmanSpecHelper.make_guesses(state, letters_to_guess)
  end

  context "when creating a new hangman state with invalid intial lives" do
    let(:lives) { -1 }

    it { is_expected.to_not be_valid }
  end

  context "when creating a new hangman state with an invalid word" do
    let(:word) { "" }

    it "shouldn't validate the state" do
      expect(state.valid?).to eq false
    end
  end

  context "when a game is created with a valid word and number of lives" do
    it { is_expected.to be_valid }
    it { is_expected.to_not be_lost }
    it { is_expected.to_not be_won }
    it { is_expected.to_not be_game_over }

    it "should have no guessed letters" do
      expect(state.guesses.length).to eq 0
    end
  end

  context "when the state runs out of guesses" do
    let(:letters_to_guess) { "z" }
    let(:lives) { 1 }

    it { is_expected.to be_lost }
    it { is_expected.to_not be_won }
    it { is_expected.to be_game_over }

    it "shouldn't have any more guesses left" do
      expect(state.number_of_guesses_remaining).to eq 0
    end

    it "should have the guessed letter stored correctly" do
      expect(state.guessed_letters.include?("z")).to eq true
    end
  end

  context "when all the letters in the word to guess are guessed" do
    let(:letters_to_guess) { "word" }

    it { is_expected.to_not be_lost }
    it { is_expected.to be_won }
    it { is_expected.to be_game_over }

    it "should have some guesses left" do
      expect(state.number_of_guesses_remaining).to be > 0
    end

    it "should have each of the guessed letters stored correctly" do
      expect(letters_to_guess.chars.all? { |letter| state.guessed_letters.include?(letter) }).to eq true
    end
  end
end
