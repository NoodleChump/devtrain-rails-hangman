require 'rails_helper'

RSpec.describe Player, type: :model do

  context "when creating a new player" do
    let(:player) { Player.new }

    it "shouldn't validate a blank player" do
      expect(player.valid?).to eq false
    end

    it "shouldn't validate a player with a tiny name" do
      player.name = "f"
      expect(player.valid?).to eq false
    end

    it "shouldn't validate a player with too long of a name" do
      player.name = "foo" * 10
      expect(player.valid?).to eq false
    end

    it "should validate a player with name of suitable length" do
      player.name = "foobar"
      expect(player.valid?).to eq true
    end
  end
end
