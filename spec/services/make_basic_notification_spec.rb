require 'rails_helper'

RSpec.describe MakeBasicNotification, type: :service do
  let(:user) { create(:named_user, name: "User") }
  let(:description) { "Hello, notifications!" }

  subject(:notification) { notification = MakeBasicNotification.new(
    to:   user,
    content: description
  ).call }

  describe "#call" do
    it "creates a new notification from sender to receiver for the game" do
      notification
      expect(user.notifications.reject(&:read?).length).to eq 1
    end

    it "has a correct description" do
      expect(notification.description).to eq description
    end

    it "has a correct action" do
      expect(notification.read_action).to eq :back
    end
  end
end
