FactoryBot.define do
  factory :buy_address do
    post_code { '123-4567' }
    prefecture_id { 3 }
    city { '奈良市' }
    address  { '1-1-1' }
    building { '奈良マンション' }
    telephone { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
