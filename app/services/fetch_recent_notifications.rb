class FetchRecentNotifications
  def initialize(user)
    @user = user
  end

  def call
    unread_notifications = Notification.where(receiver: @user, read: false).order("read, updated_at desc")
    read_notifications = Notification.where(receiver: @user, read: true).order("read, updated_at desc")
    (unread_notifications + read_notifications).first(unread_notifications.length + 5)
  end
end
