class ClearNotifications
  def initialize(user)
    @user = user
  end

  def call
    unread_notifications = Notification.where(receiver: @user, read: false).update_all(read: true)
  end
end
