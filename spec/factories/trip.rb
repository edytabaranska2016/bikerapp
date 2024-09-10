FactoryBot.define do
  factory :trip do
    start_address { 'Plac Europejski 20, Warszawa, Polska' }
    destination_address { 'Grunwaldzka 46, 32-020 Wieliczka, Polska' }
    price { 200.00 }
    date { '2024-09-10' }
  end
end
