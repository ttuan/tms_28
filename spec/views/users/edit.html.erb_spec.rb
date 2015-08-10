RSpec.describe User, "Edit profile" do
  feature "Show user profile" do
    let!(:user) {FactoryGirl.create :user}
    let!(:user1) {FactoryGirl.create :user} 

    before do
      visit "users/sign_in"      
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      click_link "Profile"
      click_link "Edit Profile"
    end

    scenario "Edit profile successfuly" do
      fill_in "Name", with: user.name
      fill_in "Email", with: user.email
      fill_in "Password", with: "12345678"
      fill_in "Confirmation", with: "12345678"
      click_button "Update"

      expect(page).to have_content "You profile has been updated!"
    end 

    scenario "Fail to edit profile if email is invalid" do
      fill_in "Name", with: user.name
      fill_in "Email", with: "test.aaaaa-@1233"
      fill_in "Password", with: user.password
      fill_in "Confirmation", with: user.password
      click_button "Update"

      expect(page).to have_content "Email is invalid"
    end

    scenario "Fail to update profile if password is blank" do
      fill_in "Name", with: user.name
      fill_in "Email", with: user.email
      click_button "Update"

      expect(page).to have_content "Password can't be blank"
    end

    scenario "Fail to edit profile if password and password confirmation doesn't match" do
      fill_in "Name", with: user.name
      fill_in "Email", with: user.password
      fill_in "Password", with: user.password
      fill_in "Confirmation", with: "1111111111"
      click_button "Update"

      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario "User cannot edit other user profile" do
      visit "/users/#{user1.id}"

      expect(page).to have_no_link "Edit profile"
    end
  end
end
