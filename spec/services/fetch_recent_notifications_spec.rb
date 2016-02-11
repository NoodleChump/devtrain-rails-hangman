require 'rails_helper'

RSpec.describe FetchRecentNotifications, type: :service do
  let(:user) { create(:user) }
  let(:another_user) { create(:named_user, name: "Test") }
  let(:game) { create(:game) }

  context "with few read and unread notifications" do
    before do
      MakeNewGameNotification.new(from: user, to: another_user, game: game).call
      MakeNewGameNotification.new(from: user, to: another_user, game: game).call.mark_read
      MakeNewGameNotification.new(from: user, to: another_user, game: game).call
    end

    it "fetches all the notifications and displays them in correct order" do
      notifications = FetchRecentNotifications.new(another_user).call
      0...notifications.length do |i|
        expect(
          (notifications[i].updated_at >= notifications[i + 1].updated_at) ||
          (notifications[i].read? && !notifications[i + 1].read?)
        ).to be true
      end
    end
  end

  context "with few unread and many read notifications" do
    before do
      MakeNewGameNotification.new(from: user, to: another_user, game: game).call
      8.times { MakeNewGameNotification.new(from: user, to: another_user, game: game).call.mark_read }
    end

    it "fetches notifications and displays them in correct order" do
      notifications = FetchRecentNotifications.new(another_user).call
      0...notifications.length do |i|
        expect(
          (notifications[i].updated_at >= notifications[i + 1].updated_at) ||
          (notifications[i].read? && !notifications[i + 1].read?)
        ).to be true
      end
    end

    it "fetches all of the unread notifications, but only some of the read ones" do
      notifications = FetchRecentNotifications.new(another_user).call
      expect(notifications.reject(&:read).length).to be 1
      expect(notifications.select(&:read).length).to be 5
    end
  end
end
