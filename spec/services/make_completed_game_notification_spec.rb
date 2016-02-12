require 'rails_helper'

RSpec.describe MakeCompletedGameNotification, type: :service do
  let(:user) { create(:named_user, name: "Bob") }
  let(:another_user) { create(:named_user, name: "Test") }
  let(:game) { create(:game) }

  subject(:notification) { notification = MakeCompletedGameNotification.new(
    from: user,
    to:   another_user,
    game: game
  ).call }

  describe "#call" do
    it "creates a new notification from sender to receiver for the game" do
      notification
      expect(another_user.notifications.reject(&:read?).length).to eq 1
    end

    it "has a correct description" do
      expect(notification.description).to eq "#{user.name} lost your game!"
    end

    it "has a correct action" do
      expect(notification.read_action).to eq game
    end
  end
end
