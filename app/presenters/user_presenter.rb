class UserPresenter < BasePresenter
  presents :user

  def gravatar
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    h.image_tag(gravatar_url, alt: user.name + " gravatar", class: "gravatar")
  end
end
