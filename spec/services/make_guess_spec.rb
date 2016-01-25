require 'rails_helper'

RSpec.describe MakeGuess, type: :service do
  let(:letter) { "a" }
  let(:game) { Game.create(word_to_guess: "word", number_of_lives: 5, user: User.create!(name: "Jordane", email: "user@user.com")) }
  let(:guess) { Guess.new(letter: letter, game: game) }
  subject(:make_guess_call) { MakeGuess.new(guess).call }

  context "when making a call to make a guess" do
    let(:letter) { "" }
    it { is_expected.to be false }
  end

  context "when making a guess with a letter that isn't in the alphabet" do
    let(:letter) { "!" }
    it { is_expected.to be false }
  end

  context "when making a guess with a word instead of a letter" do
    let(:letter) { "abc" }
    it { is_expected.to be false }
  end

  context "when making a unique guess" do
    let(:letter) { "a" }
    it { is_expected.to be true }
  end

  context "when making a non-unique guess" do
    before do
      HangmanSpecHelper.make_guess(game, letter)
    end

    it "doesn't validate when a guess for the same letter has already been made" do
      guess = game.guesses.create(letter: letter)
      expect(make_guess_call).to be false
    end

    it "doesn't save and the number of guesses taken is not affected" do
      expect(make_guess_call).to be false
      game.guesses.reload
      expect(game.guesses.length).to eq 1
    end
  end
end
