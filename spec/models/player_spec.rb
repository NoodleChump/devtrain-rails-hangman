require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:name) { "foobar" }
  subject(:player) { Player.create(name: name) }

  context "when a player's name is too small" do
    let(:name) { "f" }
    it { is_expected.to_not be_valid }
  end

  context "when a player's name is too long" do
    let(:name) { "foo" * 10 }
    it { is_expected.to_not be_valid }
  end

  context "when a player's name is of suitable length" do
    it { is_expected.to be_valid }
  end

  context "when a player's name is not unique" do
    it "shouldn't be valid" do
      player.save
      expect(Player.create(name: name)).to_not be_valid
    end
  end

  context "a player with a won and lost game" do
    subject(:player) { Player.create!(name: "Player") }
    let(:lives) { 1 }
    let(:word1) { "a" }
    let(:game1) { HangmanState.create!(word_to_guess: word1, number_of_lives: lives, player: player) }
    let(:word2) { "b" }
    let(:game2) { HangmanState.create!(word_to_guess: word2, number_of_lives: lives, player: player) }

    before do
      HangmanSpecHelper.make_guess(game1, word1)
      HangmanSpecHelper.make_guess(game2, word1)
    end

    it "should have the two games played" do
      expect(player.games.count).to eq 2
      expect([game1, game2].all? { |game| player.games.include?(game) }).to eq true
    end

    it "should have the single game won" do
      expect(player.won_games).to eq [game1]
    end

    it "should have the single game lost" do
      expect(player.lost_games).to eq [game2]
    end
  end
end
