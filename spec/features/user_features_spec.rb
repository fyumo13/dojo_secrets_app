require 'rails_helper'
feature 'User features ' do
  feature "user sign-up" do
    before(:each) do
      visit "/users/new"
    end
    scenario 'visits sign-up page' do
      expect(page).to have_field("name")
      expect(page).to have_field("email")
      expect(page).to have_field("password")
      expect(page).to have_field("password_confirmation")
    end
    scenario "with improper inputs, redirects back to sign in and shows validations" do
      click_button "Register"
      expect(current_path).to eq("/users/new")
      page.has_content?("can't be blank")
    end
    scenario "with proper inputs, create user and redirects to login page" do
      register
      expect(current_path).to eq("/sessions/new")
    end
  end
  feature "user dashboard" do
    before do
      @user = create(:user)
      log_in
    end
    scenario "displays user information" do
      expect(page).to have_content("Welcome, #{@user.name}")
    end
  end
end
