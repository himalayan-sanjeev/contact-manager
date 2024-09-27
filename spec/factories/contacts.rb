FactoryBot.define do
  factory :contact do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.unique.cell_phone.gsub(/\D/, '')[-10..-1].to_i }
  end
end
