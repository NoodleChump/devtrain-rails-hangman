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

  context "a player with a game won, lost, and in progress" do
    subject(:player) { Player.create!(name: "Player") }
    let(:lives) { 1 }
    let(:word1) { "a" }
    let(:won_game) { HangmanState.create!(word_to_guess: word1, number_of_lives: lives, player: player) }
    let(:word2) { "b" }
    let(:lost_game) { HangmanState.create!(word_to_guess: word2, number_of_lives: lives, player: player) }
    let(:word3) { "ab" }
    let(:in_progress_game) { HangmanState.create!(word_to_guess: word3, number_of_lives: lives, player: player) }

    before do
      HangmanSpecHelper.make_guess(won_game, word1)
      HangmanSpecHelper.make_guess(lost_game, word1)
      HangmanSpecHelper.make_guess(in_progress_game, word1)
    end

    it "should have the three total games" do
      expect(player.games.count).to eq 3
      expect([won_game, lost_game].all? { |game| player.games.include?(game) }).to eq true
    end

    it "should have the single game won" do
      expect(player.won_games).to eq [won_game]
    end

    it "should have the single game lost" do
      expect(player.lost_games).to eq [lost_game]
    end

    it "should have the single game in progress" do
      expect(player.in_progress_games).to eq [in_progress_game]
    end

    it "should have a win-loss ratio of 0.5" do
      expect(player.win_loss_ratio).to eq 0.5
    end

    it "should have a rank of 1 (as the only player)" do
      expect(player.ranking).to eq 1
    end
  end
end
