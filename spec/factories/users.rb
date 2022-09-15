FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { 'a12345' }
    password_confirmation { password }
    family_name           { '山田' }
    first_name            { '陸太郎' }
    family_name_kana      { 'ヤマダ' }
    first_name_kana       { 'リクタロウ' }
    birthday              { Faker::Date.between(from: '2000-01-01', to: '2022-09-14') }
  end
end
