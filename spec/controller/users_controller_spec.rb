require "rails_helper"
RSpec.describe UsersController, :vcr, type: :controller do

  describe "GET#new" do
    it "renders form" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST#create" do
    before do
      stripe_user = double(id: 1, source: "Stripe Token")
      params = { "stripeToken"=> "Stripe Token" }
      allow(controller).to receive(:stripe_token).and_return(params)
      allow(controller).to receive(:create_stripe_customer).and_return(stripe_user)
    end

    context "valid params" do
      it "increases the User count by 1 " do
        expect{ post :create }.to change{ User.count }.by(1)
      end

      it "creates a new user" do
        post :create
        
        user = assigns(:user)
        expect(user.stripe_customer_id).to eq("1")
      end
    end

    context "invalid params" do
      it "does not create a new user" do
      end
    end
  end
end
