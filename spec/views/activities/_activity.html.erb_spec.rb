RSpec.describe User, "Show activities" do
  feature "Show activities in personal page" do
    let!(:user) {FactoryGirl.create :user}
    let!(:activity) {FactoryGirl.create :activity, user_id: user.id}

    before do
      visit "users/sign_in"      
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end 

    scenario "User want to show activity" do
      click_link "Profile"

      expect(page).to have_content "Complete subject"
    end
  end
end
