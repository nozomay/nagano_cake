class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :customer
  
  validates :item_id, :customer_id, presence: true
  validates :amount, numericality:{ only_integer: true }
end
