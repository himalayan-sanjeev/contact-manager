FactoryBot.define do
  factory :contact do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.unique.cell_phone.gsub(/\D/, '')[-10..-1].to_i }
  
    after(:build) do |contact|
      contact.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/sample_image.png')),
        filename: 'sample_image.png',
        content_type: 'image/png'
      )
    end
  end
end
