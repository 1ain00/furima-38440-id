class BuyAddress
  include ActiveModel::Model
  attr_accessor :post_code, :city, :address, :telephone, :building, :prefecture_id, :item_id, :user_id
  
  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :address
    validates :telephone, format: {with: /\A[0-9]+\z/, message: "is invalid. not hyphen"}, length: {in: 10..11}, numericality: {only_integer: true}
    validates :item_id
    validates :user_id
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    buy = Buy.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, city: city, address: address, telephone: telephone, building: building, prefecture_id: prefecture_id, buy_id: buy_id)
  end
  
end