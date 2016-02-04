require 'rails_helper'

RSpec.describe GetSortedGames, type: :service do
  let(:gary) { create(:named_user, name: "Gary") }
  let(:john) { create(:named_user, name: "John") }
  let(:bob) { create(:named_user, name: "Bob") }

  let(:boring_word) { "word" }
  let(:a_word) { "a" }
  let(:other_word) { "other" }

  let(:boring_game) { Game.create!(word_to_guess: boring_word, number_of_lives: 5, user: gary) }
  let(:a_game) { Game.create!(word_to_guess: a_word, number_of_lives: 3, user: bob) }
  let(:other_game) { Game.create!(word_to_guess: other_word, number_of_lives: 1, user: john) }

  let(:users) { [gary, john, bob] }
  let(:games) { [boring_game, a_game, other_game] }

  before do
    games.each(&:save!)
  end

  describe "#apply_sort" do
    it "sorts by user name (ascending) correctly" do
      sorted_games = GetSortedGames.new('name', 'asc').call
      0...sorted_games.length do |game|
        expect(sorted_games[game].user.name <= sorted_games[game + 1].user.name).to be true
      end
    end

    it "sorts by user name (descending) correctly" do
      sorted_games = GetSortedGames.new('name', 'desc').call
      0...sorted_games.length do |game|
        expect(sorted_games[game].user.name >= sorted_games[game + 1].user.name).to be true
      end
    end

    it "sorts by number of lives remaining (ascending) correctly" do
      sorted_games = GetSortedGames.new('lives', 'asc').call
      0...sorted_games.length do |game|
        puts "sorted games: #{sorted_games}"
        puts "game index: #{game}"
        puts "sorted game: #{sorted_games[game]}"
        expect(sorted_games[game].number_of_lives_remaining <= sorted_games[game + 1].number_of_lives_remaining).to be true
      end
    end

    it "sorts by number of lives remaining (descending) correctly" do
      sorted_games = GetSortedGames.new('lives', 'desc').call
      0...sorted_games.length do |game|
        expect(sorted_games[game].number_of_lives_remaining >= sorted_games[game + 1].number_of_lives_remaining).to be true
      end
    end

    it "sorts by number of blanks remaining (ascending) correctly" do
      sorted_games = GetSortedGames.new('blanks', 'asc').call
      0...sorted_games.length do |game|
        expect(GamePresenter.new(sorted_games[game]).number_of_blanks_remaining <= GamePresenter.new(sorted_games[game + 1]).number_of_blanks_remaining).to be true
      end
    end

    it "sorts by number of blanks remaining (descending) correctly" do
      sorted_games = GetSortedGames.new('blanks', 'desc').call
      0...sorted_games.length do |game|
        expect(GamePresenter.new(sorted_games[game]).number_of_blanks_remaining >= GamePresenter.new(sorted_games[game + 1]).number_of_blanks_remaining).to be true
      end
    end

    it "sorts by the game progress (ascending) correctly" do
      sorted_games = GetSortedGames.new('progress', 'asc').call
      0...sorted_games.length do |game|
        expect(GamePresenter.new(sorted_games[game]).progression <= GamePresenter.new(sorted_games[game + 1]).progression).to be true
      end
    end

    it "sorts by the game progress (descending) correctly" do
      sorted_games = GetSortedGames.new('progress', 'desc').call
      0...sorted_games.length do |game|
        expect(GamePresenter.new(sorted_games[game]).progression >= GamePresenter.new(sorted_games[game + 1]).progression).to be true
      end
    end

    it "sorts by the game start (creation) date (ascending) correctly" do
      sorted_games = GetSortedGames.new('date', 'asc').call
      0...sorted_games.length do |game|
        expect(GamePresenter.new(sorted_games[game]).created_at <= GamePresenter.new(sorted_games[game + 1]).created_at).to be true
      end
    end

    it "sorts by the game start (creation) date (descending) correctly" do
      sorted_games = GetSortedGames.new('date', 'desc').call
      0...sorted_games.length do |game|
        expect(GamePresenter.new(sorted_games[game]).created_at >= GamePresenter.new(sorted_games[game + 1]).created_at).to be true
      end
    end

    it "sorts by if the game is custom or ranked (ascending) correctly" do
      sorted_games = GetSortedGames.new('ranked', 'asc').call
      0...sorted_games.length do |game|
        expect(GamePresenter.new(sorted_games[game]).custom <= GamePresenter.new(sorted_games[game + 1]).custom).to be true
      end
    end

    it "sorts by the game creation date (descending) correctly" do
      sorted_games = GetSortedGames.new('ranked', 'desc').call
      0...sorted_games.length do |game|
        expect(GamePresenter.new(sorted_games[game]).custom >= GamePresenter.new(sorted_games[game + 1]).custom).to be true
      end
    end

    it "sorts by the game start (creation) date (descending) by default" do
      sorted_games = GetSortedGames.new(nil, nil).call
      0...sorted_games.length do |game|
        expect(GamePresenter.new(sorted_games[game]).created_at >= GamePresenter.new(sorted_games[game + 1]).created_at).to be true
      end
    end

    context "with some guesses made" do
      before do
        HangmanSpecHelper.make_guesses(other_game, "z")
        HangmanSpecHelper.make_guesses(boring_game, "wzr")
      end

      it "sorts by game progress (ascending) correctly" do
        sorted_games = GetSortedGames.new('blanks', 'asc').call
        0...sorted_games.length do |game|
          expect(GamePresenter.new(sorted_games[game]).number_of_blanks_remaining <= GamePresenter.new(sorted_games[game + 1]).number_of_blanks_remaining).to be true
        end
      end

      it "sorts by game progress (descending) correctly" do
        sorted_games = GetSortedGames.new('blanks', 'desc').call
        0...sorted_games.length do |game|
          expect(GamePresenter.new(sorted_games[game]).number_of_blanks_remaining >= GamePresenter.new(sorted_games[game + 1]).number_of_blanks_remaining).to be true
        end
      end
    end
  end
end
