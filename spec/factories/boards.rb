FactoryGirl.define do
  factory :board do
    _id Faker::Number.number(6)
    height Faker::Number.number(2)
    width Faker::Number.number(2)
    bombs_count Faker::Number.between(1,9)
    scheme [Faker::GameOfThrones.character, Faker::GameOfThrones.house]
  end
end
