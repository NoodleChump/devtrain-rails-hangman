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

  context "when a player's name is not unique" do
    it "isn't valid" do
      player.save
      expect(Player.create(name: name)).to_not be_valid
    end
  end

  context "when a valid player is created with a name is of suitable length" do
    it { is_expected.to be_valid }

    it "has a win-loss rate of 0, having played no games" do
      expect(player.win_loss_rate).to eq 0
    end

    it "has no games total" do
      expect(player.games.count).to eq 0
    end

    it "has no games won" do
      expect(player.won_games.count).to eq 0
    end

    it "has no games lost" do
      expect(player.lost_games.count).to eq 0
    end
  end

  context "a player with a game won, lost, and in progress" do
    subject(:player) { Player.create!(name: "Player") }
    let(:player2) { Player.create!(name: "Player 2") }
    let(:lives) { 1 }
    let(:word1) { "a" }
    let(:won_game) { Game.create!(word_to_guess: word1, number_of_lives: lives, player: player) }
    let(:word2) { "b" }
    let(:lost_game) { Game.create!(word_to_guess: word2, number_of_lives: lives, player: player) }
    let(:word3) { "ab" }
    let(:in_progress_game) { Game.create!(word_to_guess: word3, number_of_lives: lives, player: player) }

    before do
      HangmanSpecHelper.make_guess(won_game, word1)
      HangmanSpecHelper.make_guess(lost_game, word1)
      HangmanSpecHelper.make_guess(in_progress_game, word1)
    end

    it "has three total games" do
      expect(player.games.count).to eq 3
      expect([won_game, lost_game].all? { |game| player.games.include?(game) }).to eq true
    end

    it "has a single game won" do
      expect(player.won_games).to eq [won_game]
    end

    it "has a single game lost" do
      expect(player.lost_games).to eq [lost_game]
    end

    it "has a single game in progress" do
      expect(player.in_progress_games).to eq [in_progress_game]
    end

    it "has a win-loss rate of 1.0" do
      expect(player.win_loss_rate).to eq 1.0
    end

    it "has a rank of 1 (as the only player having played games)" do
      expect(player.ranking).to eq 1
    end

    it "has player 2 with a rank of 2" do
      expect(player2.ranking).to eq 2
    end
  end
end
