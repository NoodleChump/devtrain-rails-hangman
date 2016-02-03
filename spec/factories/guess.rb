FactoryGirl.define do
  factory :guess do
    letter "a"
    association :game, factory: :game
  end
end
