require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { "foobar" }
  let(:email) { "foo@bar.com" }

  subject(:user) { build(:user, name: name, email: email) }

  context "when creating a user with a name that is too small" do
    subject(:user) { build(:user, name: "f") }
    it { is_expected.to_not be_valid }
  end

  context "when creating a user with a name that is too long" do
    subject(:user) { build(:user, name: "foo" * 100) }
    it { is_expected.to_not be_valid }
  end

  context "when creating a user with a name that isn't unique" do
    before do
      create(:user, name: "name", email: "unique@example.com")
    end

    subject(:user) { build(:user, name: "name") }
    it { is_expected.to_not be_valid }
  end

  context "when creating a user with an email that isn't unique" do
    before do
      create(:user, email: "a@a.com", name: "Unique")
    end

    subject(:user) { build(:user, email: "a@a.com") }
    it { is_expected.to_not be_valid }
  end

  context "when creating a user without a password" do
    subject(:user) { build(:user, password: "") }

    it { is_expected.not_to be_valid }
  end

  context "when creating a user with a password that is too short" do
    subject(:user) { build(:user, password: "a" * 5) }

    it { is_expected.not_to be_valid }
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
    subject(:john) { create(:named_user, name: "John") }
    subject(:bob) { create(:named_user, name: "Bob") }

    let(:won_game) { create(:game, word_to_guess: "a", number_of_lives: 1, user: john) }
    let(:lost_game) { create(:game, word_to_guess: "b", number_of_lives: 1, user: john) }
    let(:in_progress_game) { create(:game, word_to_guess: "ab", number_of_lives: 1, user: john) }

    before do
      HangmanSpecHelper.make_guesses(won_game, "a")
      HangmanSpecHelper.make_guesses(lost_game, "a")
      HangmanSpecHelper.make_guesses(in_progress_game, "a")
      user.games.reload
    end

    it "has three total games" do
      expect(john.games.count).to eq 3
      expect([won_game, lost_game].all? { |game| john.games.include?(game) }).to eq true
    end

    it "has a single game won" do
      expect(john.won_games).to eq [won_game]
    end

    it "has a single game lost" do
      expect(john.lost_games).to eq [lost_game]
    end

    it "has a single game in progress" do
      expect(john.in_progress_games).to eq [in_progress_game]
    end

    it "has a win-loss rate of 0.0 (as games are marked custom)" do
      [won_game, lost_game].each { |game| game.update_attribute(:custom, true) }

      expect(john.win_loss_rate).to eq 0.0
    end

    it "has a win-loss rate of 1.0 (as games are marked ranked)" do
      expect(john.win_loss_rate).to eq 1.0
    end

    it "has john having a higher rank score than bob" do
      expect(john.reload.rank_points > bob.reload.rank_points).to be true
    end
  end
end
