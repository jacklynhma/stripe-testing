class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    Stripe.api_key = "sk_test_67VIDDWRpzE3Si7LeH3u4nD5"

    token = params[:stripeToken]
    begin
      customer = create_stripe_customer(stripe_token)
      @user = User.new(stripe_customer_id: customer.id)
      @user.save

    # https://stripe.com/docs/api#error_handling
    rescue Stripe::StripeError => error
      flash[:error] = error
      render :new
    rescue StandardError => error
      flash[:error] = error
      render :new
    else
      flash[:notice] = "User was successfully created"
      redirect_to users_path
    end
  end

  private

  def stripe_token
    params.require(:stripeToken)
  end

  def create_stripe_customer(stripe_token)
    customer = Stripe::Customer.create(
      source: stripe_token
    )
  end
end
