class ProductOrder < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum production_status: { cannot_produce: 0, waiting_production: 1, production: 2, production_completed:3 }
end
