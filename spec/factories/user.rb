FactoryGirl.define do
  factory :user, aliases: [:player] do
    name "John Doe"
    email { "#{name}@example.com".squish.downcase.tr(" ", "_") }
    password "abcd1234"
    password_confirmation "abcd1234"
  end

  factory :admin, class: User do
    name "Administrator"
    email { "#{name}@example.com".squish.downcase.tr(" ", "_") }
    password "somethingsecure"
    password_confirmation "somethingsecure"
    admin true
  end
end
