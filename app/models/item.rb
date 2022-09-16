class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days_to_ship



  with_options presence: true do
   with_options numericality: { other_than: 1 , message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  validates :name
  validates :text
  validates_numericality_of :price, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_9999_999
  validates :price, format: { with: /\A[0-9]+\z/}
  validates :images
 end

 #validates_length_of :iame, maximum: 40
 #validates_length_of :text, maximum: 1000

  #has_one :buy
  belongs_to :user
  has_one_attached :image

end
