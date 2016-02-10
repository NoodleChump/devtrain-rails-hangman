class NewGameNotification < Notification
  belongs_to :game

  def description
    "#{sender.name} sent you a new game!"
  end
end
