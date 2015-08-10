RSpec.describe User, "Show profile" do
  feature "Show user profile" do
    let!(:user) {FactoryGirl.create :user}
    let!(:user1) {FactoryGirl.create :user}
    let!(:admin) {FactoryGirl.create :admin}

    before do
      visit "users/sign_in"      
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    scenario "User want to show profile" do
      click_link "Profile"

      expect(page).to have_content user.name
      expect(page).to have_content user.email
      expect(page).to have_link "Edit Profile"
    end

    scenario "Normal user cannot see admin profile" do
      visit "/users/#{admin.id}"

      expect(page).to have_content "You are not authorized to access this page."
    end

    scenario "User can see other user profile" do
      visit "/users/#{user1.id}"

      expect(page).to have_content user1.name 
      expect(page).to have_content user1.email
    end
  end
end
