class User < ApplicationRecord
  validates :stripe_customer_id, presence: true

  # def create_stripe_customer(stripe_token)
  #   customer = Stripe::Customer.create(
  #     source: stripe_token
  #   )
  # end
end
