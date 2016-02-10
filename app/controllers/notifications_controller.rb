class NotificationsController < ApplicationController
  before_action :find_notification

  def show
    @notification.read = true
    @notification.save!
    redirect_to @notification.read_action if @notification.read_action
  end

  private

  def find_notification
    @notification = Notification.find(params[:id])
  end

  def guess_params
    params.require(:notification).permit(:sender_id, :receiver_id, :game_id)
  end
end
