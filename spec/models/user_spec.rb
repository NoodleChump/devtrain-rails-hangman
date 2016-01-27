require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { "foobar" }
  let(:email) { "foo@bar.com" }
  subject(:user) { User.create!(name: name, email: email, password: "foobar", password_confirmation: "foobar") }

  context "when creating a user with a name that is too small" do
    it "it doesn't pass validation" do
      expect { User.create!(name: "f", email: email, password: "foobar", password_confirmation: "foobar") }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  context "when creating a user with a name that is too long" do
    it "it doesn't pass validation" do
      expect { User.create!(name: "foo" * 50, email: email, password: "foobar", password_confirmation: "foobar") }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  context "when creating a user with a name that isn't unique" do
    it "it doesn't pass validation" do
      user.save!
      expect { User.create!(name: name, email: email, password: "foobar", password_confirmation: "foobar") }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  context "when creating a user with an email that isn't unique" do
    it "it doesn't pass validation" do
      user.save!
      expect { User.create!(name: "name", email: email.upcase, password: "foobar", password_confirmation: "foobar") }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  context "when creating a user without a password" do
    before do
      user.password = user.password_confirmation = ""
    end

    it { is_expected.not_to be_valid }
  end

  context "when creating a user with a password that is too short" do
    before do
      user.password = user.password_confirmation = "a" * 5
    end

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
    subject(:user) { User.create!(name: "User", email: "foo@bar.com", password: "foobar", password_confirmation: "foobar") }
    subject(:another_user) { User.create!(name: "Another User", email: "bar@foo.com", password: "foobar", password_confirmation: "foobar") }
    let(:lives) { 1 }
    let(:word_a) { "a" }
    let(:won_game) { Game.create!(word_to_guess: word_a, number_of_lives: lives, user: user, custom: false) }
    let(:word_b) { "b" }
    let(:lost_game) { Game.create!(word_to_guess: word_b, number_of_lives: lives, user: user, custom: false) }
    let(:word_ab) { "ab" }
    let(:in_progress_game) { Game.create!(word_to_guess: word_ab, number_of_lives: lives, user: user, custom: false) }

    before do
      HangmanSpecHelper.make_guess(won_game, word_a)
      HangmanSpecHelper.make_guess(lost_game, word_a)
      HangmanSpecHelper.make_guess(in_progress_game, word_a)
      user.games.reload
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

    it "has a win-loss rate of 0.0 (as games are marked custom)" do
      expect(user.win_loss_rate).to eq 1.0
    end

    it "has a win-loss rate of 1.0 (as games are marked ranked)" do
      won_game.update_attribute(:custom, false)
      lost_game.update_attribute(:custom, false)
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
