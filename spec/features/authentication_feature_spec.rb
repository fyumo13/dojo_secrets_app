require 'rails_helper'
feature 'authentication feature' do
  before do
    @user = create(:user)
  end
  feature "user attempts to sign-in" do
    scenario 'visits sign-in page, prompted with email and password fields' do
      visit '/sessions/new'
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
    end
    scenario 'logs in user if email/password combination is valid' do
      log_in
      expect(current_path).to eq("/users/#{@user.id}")
      expect(page).to have_content("Welcome, #{@user.name}")
    end
    scenario 'does not sign in user if email is not found' do
      log_in email: "wrongemail@gmail.com"
      expect(current_path).to eq("/sessions/new")
      page.has_content?("Invalid email/password combination")
    end
    scenario 'does not sign in user if email/password combination is invalid' do
      log_in password: "wrong password"
      expect(current_path).to eq("/sessions/new")
      page.has_content?("Invalid email/password combination")
    end
  end
  feature "user attempts to log out" do
    before do
      log_in
    end
    scenario 'displays "Log Out" button when user is logged on' do
      expect(page).to have_button("Log Out")
    end
    scenario 'logs out user and redirects to login page' do
      click_button "Log Out"
      expect(current_path).to eq("/sessions/new")
    end
  end
end
