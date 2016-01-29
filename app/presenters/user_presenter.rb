class UserPresenter
  def initialize(user)
    @user = user
  end

  def gravatar
    gravatar_id = Digest::MD5::hexdigest(@user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    html.image_tag(gravatar_url, alt: @user.name + " gravatar", class: "gravatar")
  end

  def small_gravatar
    gravatar_id = Digest::MD5::hexdigest(@user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=32"
    html.image_tag(gravatar_url, alt: @user.name + " gravatar", class: "gravatar-small")
  end

  private

  def html
    @html ||= ActionView::Base.new.extend(ActionView::Helpers::TagHelper)
  end
end
