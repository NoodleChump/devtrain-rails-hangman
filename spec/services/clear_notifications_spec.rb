require 'rails_helper'

RSpec.describe ClearNotifications, type: :service do
  let(:user) { create(:user) }
  let(:another_user) { create(:named_user, name: "Test") }
  let(:game) { create(:game) }

  context "with some read and unread notifications" do
    before do
      MakeNewGameNotification.new(from: user, to: another_user, game: game).call
      read_notification = MakeNewGameNotification.new(from: user, to: another_user, game: game).call
      read_notification.mark_read
    end

    it "clears read notifications" do
      ClearNotifications.new(another_user).call
      expect(another_user.notifications.reject(&:read?)).to be_empty
      expect(another_user.notifications.select(&:read?).size).to eq 2
    end
  end
end
