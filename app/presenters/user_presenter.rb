class UserPresenter
  def initialize(user)
    @user = user
  end

  def gravatar(size: :full)
    html.image_tag(gravatar_url(size: size), alt: @user.name + " gravatar", class: "gravatar")
  end

  private

  def gravatar_url(size: :full)
    gravatar_id = Digest::MD5::hexdigest(@user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?#{gravatar_size_parameter(size)}"
  end

  def gravatar_size_parameter(size)
    case size
    when :small
      "s=32"
    when :medium
      "s=64"
    when :full
      ""
    end
  end

  def html
    @html ||= ActionView::Base.new.extend(ActionView::Helpers::TagHelper)
  end
end
