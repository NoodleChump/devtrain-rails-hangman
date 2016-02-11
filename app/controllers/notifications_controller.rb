class NotificationsController < ApplicationController
  before_action :find_notification, only: :show

  def index
    @notifications = FetchRecentNotifications.new(User.find(params[:user_id])).call
    @unread_notifications = @notifications.reject(&:read?).length
  end

  def show
    @notification.read = true
    @notification.save!
    redirect_to @notification.read_action
  end

  def destroy
    ClearNotifications.new(current_user).call
    render nothing: true
  end

  private

  def find_notification
    @notification = Notification.find(params[:id])
  end

  def guess_params
    params.require(:notification).permit(:sender_id, :receiver_id, :game_id)
  end
end
