class NewGameNotification < Notification
  belongs_to :game

  before_save :generate_description

  def description
    "#{sender.name} sent you a new game!"
  end
end
