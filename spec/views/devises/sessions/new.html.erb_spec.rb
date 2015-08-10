RSpec.describe User, "login" do
  feature "Log in" do
    let!(:user) {FactoryGirl.create :user}

    scenario "Successful sign in" do
      visit "/users/sign_in"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"

      expect(page).to have_content "Signed in successfully."
    end

    scenario "Sign in failed" do
      visit "/users/sign_in"
      fill_in "Email", with: user.email
      fill_in "Password", with: "12345678"
      click_button "Log in"

      expect(page).to have_content "Invalid email or password."
    end
  end
end
