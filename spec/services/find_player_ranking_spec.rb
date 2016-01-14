require 'rails_helper'

RSpec.describe FindPlayerRanking, type: :service do
  let(:leading_player) { Player.create!(name: "Lead") }
  let(:trailing_player) { Player.create!(name: "Trailing") }

  let(:letter) { "a" }
  let(:game) { Game.create!(word_to_guess: letter, number_of_lives: 5, player: leading_player) }
  let(:guess) { Guess.create!(letter: letter, game: game) }

  context "when making a service call" do
    it "has a first place ranking for the leading player" do
      expect(FindPlayerRanking.new(leading_player).call).to eq 1
    end

    it "has a last place ranking for the trailing player" do
      expect(FindPlayerRanking.new(leading_player).call).to eq Player.all.length
    end
  end
end
