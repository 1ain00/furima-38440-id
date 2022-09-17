FactoryBot.define do
  factory :item do
    name {Faker::Coffee.blend_name}
    price {Faker::Number.between(from: 300, to: 9_9999_999)}
    category_id {2}
    status_id {2}
    delivery_fee_id {2}
    prefecture_id {2}
    days_to_ship_id {2}
    text {Faker::Coffee.blend_name}
    
  
    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
