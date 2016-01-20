require 'rails_helper'

RSpec.describe FindUserRanking, type: :service do
  let(:leading_user) { User.create!(name: "Lead") }
  let(:trailing_user) { User.create!(name: "Trailing") }

  let(:letter) { "a" }
  let(:game) { Game.create!(word_to_guess: letter, number_of_lives: 5, user: leading_user) }
  let(:guess) { Guess.create!(letter: letter, game: game) }

  context "when making a service call" do
    it "has a first place ranking for the leading user" do
      expect(FindUserRanking.new(leading_user).call).to eq 1
    end

    it "has a last place ranking for the trailing user" do
      expect(FindUserRanking.new(leading_user).call).to eq User.all.length
    end
  end
end
