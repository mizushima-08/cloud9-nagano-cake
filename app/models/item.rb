class Item < ApplicationRecord
  validates :introduction, presence: true
	validates :price, 		  presence: true
	validates :name, 		  presence: true

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :product_orders, dependent: :destroy
  attachment :image
  def with_tax_price
    (price * 1.1).floor
  end
end
