require 'rails_helper'

RSpec.describe Guess, type: :model do

  context "when creating a new guess" do
    let(:guess) { Guess.new }

    it "doesn't validate a blank guess" do
      expect(guess.valid?).to eq false
    end

    it "doesn't validate a guess with a letter that isn't in the alphabet" do
      guess.letter = "!"
      expect(guess.valid?).to eq false
    end

    it "doesn't validate a guess when the letter is more than a single character" do
      guess.letter = "abc"
      expect(guess.valid?).to eq false
    end

    it "validates a guess with a letter that is in the alphabet" do
      guess.letter = "a"
      expect(guess.valid?).to eq true
    end
  end
end
