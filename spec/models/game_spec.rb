require 'rails_helper'

RSpec.describe Game, type: :model do

  let(:word) { "word" }
  let(:lives) { 5 }
  let(:letters_to_guess) { "" }
  let(:user) { User.create!(name: "Jordane") }

  subject(:game) { Game.create(word_to_guess: word, number_of_lives: lives, user: user) }

  before do
    HangmanSpecHelper.make_guesses(game, letters_to_guess)
  end

  context "when creating a new game with invalid intial lives" do
    let(:lives) { -1 }

    it { is_expected.to_not be_valid }
  end

  context "when creating a new game with a blank word" do
    let(:word) { "" }

    it { is_expected.to be_valid }

    it "has a random word created in it's place" do
      expect(game.word_to_guess).to be_present
    end
  end

  context "when a game is created with a valid word and number of lives" do
    it { is_expected.to be_valid }
    it { is_expected.to_not be_lost }
    it { is_expected.to_not be_won }
    it { is_expected.to_not be_game_over }

    it "has no guessed letters" do
      expect(game.guesses.length).to eq 0
    end

    it "has a completely censored word" do
      expect(game.censored_word).to eq [nil] * word.length
    end
  end

  context "when the game runs out of guesses" do
    let(:letters_to_guess) { "z" }
    let(:lives) { 1 }

    it { is_expected.to be_lost }
    it { is_expected.to_not be_won }
    it { is_expected.to be_game_over }

    it "doesn't have any more guesses left" do
      expect(game.number_of_lives_remaining).to eq 0
    end

    it "has it's guesses associated correctly" do
      expect(game.guessed_letters).to include letters_to_guess
    end
  end

  context "when all the letters in the word to guess are guessed without mistake" do
    let(:letters_to_guess) { "word" }

    it { is_expected.to_not be_lost }
    it { is_expected.to be_won }
    it { is_expected.to be_game_over }

    it "has some guesses left" do
      expect(game.number_of_lives_remaining).to be > 0
    end

    it "has each of the guessed letters stored correctly" do
      expect(game.guessed_letters).to match_array letters_to_guess.chars
    end

    it "has a completely uncensored word" do
      expect(game.censored_word).to eq word.chars
    end
  end

  context "when there are some correct and incorrect guesses in a running game" do
    let(:letters_to_guess) { "woxz" }
    let(:lives) { 4 }

    it { is_expected.to_not be_lost }
    it { is_expected.to_not be_won }
    it { is_expected.to_not be_game_over }

    it "has some guesses left" do
      expect(game.number_of_lives_remaining).to be > 0
    end

    it "has a partially censored word" do
      expect(game.censored_word).to eq "wo".chars + [nil] * 2
    end
  end
end
