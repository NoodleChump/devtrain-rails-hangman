require 'rails_helper'

RSpec.describe MakeCompletedGameNotification, type: :service do
  let(:user) { create(:user) }
  let(:another_user) { create(:named_user, name: "Test") }
  let(:game) { create(:game) }

  describe "#call" do
    it "creates a new notification from sender to receiver for the game" do
      MakeCompletedGameNotification.new(from: user, to: another_user, game: game).call
      expect(another_user.notifications.reject(&:read?).length).to eq 1
    end
  end
end

#TODO Also make feature specs for notifications, read/unread
