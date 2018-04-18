require 'rails_helper'
RSpec.describe "creates new user", :vcr, type: :system, js: true do
  before(:each) do
    visit users_path
    click_link "Create New User"
  end

  context "user inputs valid params with a US credit card" do
    it "displays a success message" do
      expect(page).to have_content("Add a Customer")

      # https://gist.github.com/nruth/b2500074749e9f56e0b7
      within_frame '__privateStripeFrame3' do
        fill_in 'cardnumber', with: "4242 4242 4242 4242"
        fill_in 'exp-date', with: '11/27'
        fill_in 'cvc', with: '234'
        fill_in 'postal', with: '12345'
      end
      click_button "submit"

      expect(page).to have_content("All Users")
      expect(page).to have_content("User was successfully created")
    end
  end

  context "user enters an expired credit card" do
    it "displays an expired credit card error message" do
      expect(page).to have_content("Add a Customer")

      within_frame '__privateStripeFrame3' do
        fill_in 'cardnumber', with: "4242 4242 4242 4242"
        fill_in 'exp-date', with: '11/12'
        fill_in 'cvc', with: '234'
        fill_in 'postal', with: '12345'
      end

      expect(find("#card-errors").text).to eq("Your card's expiration year is in the past.")
    end
  end

  context "user inputs valid params with out state credit card" do
    it "displays a success message without having to enter credit card" do
      expect(page).to have_content("Add a Customer")

      # https://gist.github.com/nruth/b2500074749e9f56e0b7
      within_frame '__privateStripeFrame3' do
        fill_in 'cardnumber', with: '4000000760000002'
        fill_in 'exp-date', with: '11/27'
        fill_in "cvc", with: '234'
      end
      click_button "submit"

      expect(page).to have_content("All Users")
      expect(page).to have_content("User was successfully created")
    end
  end
end
