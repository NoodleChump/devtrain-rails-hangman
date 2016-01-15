require 'rails_helper'

RSpec.describe PlayersPresenter, type: :presenter do
  let(:player) { Player.create!(name: "Player") }
  let(:other_player) { Player.create!(name: "Other Player") }
  let(:ai_player) { Player.create!(name: "AI Player") }

  let(:boring_word) { "word" }
  let(:a_word) { "a" }
  let(:other_word) { "other" }

  let(:boring_game) { Game.create!(word_to_guess: boring_word, number_of_lives: 5, player: player) }
  let(:a_game) { Game.create!(word_to_guess: a_word, number_of_lives: 3, player: ai_player) }
  let(:other_game) { Game.create!(word_to_guess: other_word, number_of_lives: 1, player: other_player) }

  let(:players) { [player, ai_player, other_player] }

  describe "#apply_sort" do
    before do
      HangmanSpecHelper::make_guess(other_game, "z") # lost
      HangmanSpecHelper::make_guesses(boring_game, "wzr") # in progress
      HangmanSpecHelper::make_guesses(a_game, "a") # won
    end

    context "when sorting by name" do
      it "sorts (ascending) correctly" do
        sorted_players = PlayersPresenter.apply_sort(players, 'name', 'asc')
        expect(sorted_players).to eq [ai_player, other_player, player]
      end

      it "sorts (descending) correctly" do
        sorted_players = PlayersPresenter.apply_sort(players, 'name', 'desc')
        expect(sorted_players).to eq [player, other_player, ai_player]
      end
    end

    context "when sorting by ranking" do
      it "sorts (ascending) correctly" do
        sorted_players = PlayersPresenter.apply_sort(players, 'ranking', 'asc')
        expect(sorted_players).to eq [ai_player, player, other_player]
      end

      it "sorts (descending) correctly" do
        sorted_players = PlayersPresenter.apply_sort(players, 'ranking', 'desc')
        expect(sorted_players).to eq [other_player, player, ai_player]
      end
    end
  end
end
