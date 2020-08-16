FactoryBot.define do
  factory :recipe do
    user

    name { 'Keto Air Fryer Salmon Cakes with Sriracha Mayo' }

    directions { 'very very tasty'}
    cooking_time { 2 }
    servings { 2 }

    factory :ingredient do
      name { 'bla' }
    end
  end
end
