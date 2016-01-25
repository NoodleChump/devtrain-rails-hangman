require 'rails_helper'

RSpec.describe GamesPresenter, type: :presenter do
  let(:user) { User.create!(name: "User", email: "user@user.com") }
  let(:other_user) { User.create!(name: "Other User", email: "another@user.com") }
  let(:ai_user) { User.create!(name: "AI User", email: "more@user.com") }

  let(:boring_word) { "word" }
  let(:a_word) { "a" }
  let(:other_word) { "other" }

  let(:boring_game) { Game.create!(word_to_guess: boring_word, number_of_lives: 5, user: user) }
  let(:a_game) { Game.create!(word_to_guess: a_word, number_of_lives: 3, user: ai_user) }
  let(:other_game) { Game.create!(word_to_guess: other_word, number_of_lives: 1, user: other_user) }

  let(:games) { [boring_game, a_game, other_game] }

  describe "#apply_sort" do
    it "sorts by user name (ascending) correctly" do
      sorted_games = GamesPresenter.apply_sort(games, 'name', 'asc')
      expect(sorted_games).to eq [a_game, other_game, boring_game]
    end

    it "sorts by user name (descending) correctly" do
      sorted_games = GamesPresenter.apply_sort(games, 'name', 'desc')
      expect(sorted_games).to eq [boring_game, other_game, a_game]
    end

    it "sorts by number of lives remaining (ascending) correctly" do
      sorted_games = GamesPresenter.apply_sort(games, 'guesses', 'asc')
      expect(sorted_games).to eq [other_game, a_game, boring_game]
    end

    it "sorts by number of lives remaining (descending) correctly" do
      sorted_games = GamesPresenter.apply_sort(games, 'guesses', 'desc')
      expect(sorted_games).to eq [boring_game, a_game, other_game]
    end

    it "sorts by number of blanks remaining (ascending) correctly" do
      sorted_games = GamesPresenter.apply_sort(games, 'blanks', 'asc')
      expect(sorted_games).to eq [a_game, boring_game, other_game]
    end

    it "sorts by number of blanks remaining (descending) correctly" do
      sorted_games = GamesPresenter.apply_sort(games, 'blanks', 'desc')
      expect(sorted_games).to eq [other_game, boring_game, a_game]
    end

    context "with some guesses made" do
      before do
        HangmanSpecHelper::make_guess(other_game, "z") # lost
        HangmanSpecHelper::make_guesses(boring_game, "wzr") # in progress
      end

      it "sorts by game progress (ascending) correctly" do
        sorted_games = GamesPresenter.apply_sort(games, 'blanks', 'asc')
        expect(sorted_games).to eq [other_game, a_game, boring_game]
      end

      it "sorts by game progress (descending) correctly" do
        sorted_games = GamesPresenter.apply_sort(games, 'blanks', 'desc')
        expect(sorted_games).to eq [boring_game, a_game, other_game]
      end
    end
  end
end
