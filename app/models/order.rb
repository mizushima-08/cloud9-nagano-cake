class Order < ApplicationRecord
  belongs_to :customer
  has_many :product_orders, dependent: :destroy
  # attachment :image
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_deposit: 0, confirmation: 1, production: 2, ready_ship: 3, sent:4 }
end
