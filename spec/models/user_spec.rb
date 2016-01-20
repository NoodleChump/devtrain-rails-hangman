require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { "foobar" }
  subject(:user) { User.create!(name: name) }

  context "when creating a user with a name that is too small" do
    it "it doesn't pass validation" do
      expect { User.create!(name: "f") }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  context "when creating a user with a name that is too long" do
    it "it doesn't pass validation" do
      expect { User.create!(name: "foo" * 10) }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  context "when creating a user with a name that isn't unique" do
    it "it doesn't pass validation" do
      user.save!
      expect { User.create!(name: name) }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  context "when a valid user is created with a name is of suitable length" do
    it { is_expected.to be_valid }

    it "has a win-loss rate of 0, having played no games" do
      expect(user.win_loss_rate).to eq 0
    end

    it "has no games total" do
      expect(user.games.count).to eq 0
    end

    it "has no games won" do
      expect(user.won_games.count).to eq 0
    end

    it "has no games lost" do
      expect(user.lost_games.count).to eq 0
    end
  end

  context "a user with a game won, lost, and in progress" do
    subject(:user) { User.create!(name: "User") }
    subject(:another_user) { User.create!(name: "Another User") }
    let(:lives) { 1 }
    let(:word_a) { "a" }
    let(:won_game) { Game.create!(word_to_guess: word_a, number_of_lives: lives, user: user) }
    let(:word_b) { "b" }
    let(:lost_game) { Game.create!(word_to_guess: word_b, number_of_lives: lives, user: user) }
    let(:word_ab) { "ab" }
    let(:in_progress_game) { Game.create!(word_to_guess: word_ab, number_of_lives: lives, user: user) }

    before do
      HangmanSpecHelper.make_guess(won_game, word_a)
      HangmanSpecHelper.make_guess(lost_game, word_a)
      HangmanSpecHelper.make_guess(in_progress_game, word_a)
    end

    it "has three total games" do
      expect(user.games.count).to eq 3
      expect([won_game, lost_game].all? { |game| user.games.include?(game) }).to eq true
    end

    it "has a single game won" do
      expect(user.won_games).to eq [won_game]
    end

    it "has a single game lost" do
      expect(user.lost_games).to eq [lost_game]
    end

    it "has a single game in progress" do
      expect(user.in_progress_games).to eq [in_progress_game]
    end

    it "has a win-loss rate of 1.0" do
      expect(user.win_loss_rate).to eq 1.0
    end

=begin
    it "has a rank of 1 (as the only user having played games)" do
      expect(user.ranking).to eq 1
    end

    it "has user 2 with a rank of 2" do
      expect(another_user.ranking).to eq 2
    end
=end

  end
end
