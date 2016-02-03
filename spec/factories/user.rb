FactoryGirl.define do
  factory :user, aliases: [:player] do
    name "John Doe"
    email "john.doe@example.com"
    password "abcd1234"
    password_confirmation { password }

    factory :admin do
      admin true
    end

    factory :named_user do
      email { "#{name.squish.tr(" ", ".")}@example.com".downcase }
    end
  end
end
