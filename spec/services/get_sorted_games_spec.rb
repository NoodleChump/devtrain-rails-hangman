require 'rails_helper'

RSpec.describe GetSortedGames, type: :service do
  let(:user) { User.create!(name: "User", email: "user@user.com", password: "foobar", password_confirmation: "foobar") }
  let(:other_user) { User.create!(name: "Other User", email: "another@user.com", password: "foobar", password_confirmation: "foobar") }
  let(:ai_user) { User.create!(name: "AI User", email: "more@user.com", password: "foobar", password_confirmation: "foobar") }

  let(:boring_word) { "word" }
  let(:a_word) { "a" }
  let(:other_word) { "other" }

  let(:boring_game) { Game.create!(word_to_guess: boring_word, number_of_lives: 5, user: user) }
  let(:a_game) { Game.create!(word_to_guess: a_word, number_of_lives: 3, user: ai_user) }
  let(:other_game) { Game.create!(word_to_guess: other_word, number_of_lives: 1, user: other_user) }

  let(:users) { [user, other_user, ai_user] }
  let(:games) { [boring_game, a_game, other_game] }

  before do
    games.each(&:save!)
  end

  describe "#apply_sort" do
    it "sorts by user name (ascending) correctly" do
      sorted_games = GetSortedGames.new('name', 'asc').call
      0...sorted_games.count do |game|
        expect(sorted_games[game].user.name <= sorted_games[game + 1].user.name).to be true
      end
    end

    it "sorts by user name (descending) correctly" do
      sorted_games = GetSortedGames.new('name', 'desc').call
      expect(sorted_games).to eq [boring_game, other_game, a_game]
    end

    it "sorts by number of lives remaining (ascending) correctly" do
      sorted_games = GetSortedGames.new('lives', 'asc').call
      expect(sorted_games).to eq [other_game, a_game, boring_game]
    end

    it "sorts by number of lives remaining (descending) correctly" do
      sorted_games = GetSortedGames.new('lives', 'desc').call
      expect(sorted_games).to eq [boring_game, a_game, other_game]
    end

    it "sorts by number of blanks remaining (ascending) correctly" do
      sorted_games = GetSortedGames.new('blanks', 'asc').call
      expect(sorted_games).to eq [a_game, boring_game, other_game]
    end

    it "sorts by number of blanks remaining (descending) correctly" do
      sorted_games = GetSortedGames.new('blanks', 'desc').call
      expect(sorted_games).to eq [other_game, boring_game, a_game]
    end

    context "with some guesses made" do
      before do
        HangmanSpecHelper.make_guesses(other_game, "z") # lost
        HangmanSpecHelper.make_guesses(boring_game, "wzr") # in progress
      end

      it "sorts by game progress (ascending) correctly" do
        sorted_games = GetSortedGames.new('blanks', 'asc').call
        expect(sorted_games).to eq [other_game, a_game, boring_game]
      end

      it "sorts by game progress (descending) correctly" do
        sorted_games = GetSortedGames.new('blanks', 'desc').call
        expect(sorted_games).to eq [boring_game, a_game, other_game]
      end
    end
  end
end
