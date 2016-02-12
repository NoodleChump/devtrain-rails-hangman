class MakeBasicNotification
  def initialize(from: nil, to: nil, content: nil)
    @sender = from
    @receiver = to
    @content = content
  end

  def call
    Notification.create!(
      sender:   @sender,
      receiver: @receiver,
      description:  @content
    )
  end
end
