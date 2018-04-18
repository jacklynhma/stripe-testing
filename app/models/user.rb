class User < ApplicationRecord
  validates :stripe_customer_id, presence: true
end
