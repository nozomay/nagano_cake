class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :item_id, :order_id, presence: true
  validates :price, :amount, numericality: { only_integer: true }

  enum making_status: { notmaking: 0, standby: 1, making: 2, finish: 3 }
end
