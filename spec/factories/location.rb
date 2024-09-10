FactoryBot.define do
  factory :location do
    trait :start do
      address { 'Plac Europejski 20, Warszawa, Polska' }
      latitude { 52.232632550000005 }
      longitude { 20.984259292137956 }
    end

    trait :destination do
      address { 'Grunwaldzka 46, 32-020 Wieliczka, Polska' }
      latitude { 49.9900445 }
      longitude { 20.0762255 }
    end
  end
end
