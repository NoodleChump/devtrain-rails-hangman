require 'rails_helper'

RSpec.describe MakeGuess, type: :service do
  let(:letter) { "a" }
  let(:game) { Game.create(word_to_guess: "word", number_of_lives: 5, user: create(:user)) }
  let(:make_guess) { MakeGuess.new(game, letter).call }
  subject(:guess_made?) { make_guess.persisted? }

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
      HangmanSpecHelper.make_guesses(game, letter)
    end

    it { is_expected.to be false }

    it "doesn't save and the number of guesses taken is not affected" do
      expect{ make_guess }.to change{ game.guesses.length }.by(0)
    end
  end
end
