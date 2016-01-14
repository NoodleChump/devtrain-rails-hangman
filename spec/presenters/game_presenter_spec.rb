require 'rails_helper'

RSpec.describe GamePresenter, type: :presenter do
  let(:player) { Player.create!(name: "Player") }
  let(:word) { "word" }
  let(:game) { Game.create!(word_to_guess: word, number_of_lives: 5, player: player) }

  subject(:presented_game) { GamePresenter.new(game) }

  context "when a new game is started without any guesses" do
    it "has a completely censored word" do
      expect(presented_game.censored_word).to eq GamePresenter::CENSOR_CHARACTER * word.length
    end
  end
end
