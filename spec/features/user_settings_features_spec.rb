require 'rails_helper'
feature 'User Settings features' do
  before do
    @user = create(:user)
    log_in
  end
  feature "User Settings Dashboard" do
    before(:each) do
      visit "/users/#{@user.id}/edit"
    end
    scenario "visit users edit page" do
      expect(page).to have_field("name")
      expect(page).to have_field("email")
    end
    scenario "inputs filled out correctly" do
      expect(find_field("name").value).to eq(@user.name)
      expect(find_field("email").value).to eq(@user.email)
    end
    scenario "incorrectly updates information" do
      fill_in "name", with: "John"
      fill_in "email", with: "wrong email"
      click_button "Update"
      expect(current_path).to eq("/users/#{@user.id}/edit")
      page.has_content?("Email is invalid")
    end
    scenario "correctly updates information" do
      fill_in "name", with: "John"
      fill_in "email", with: "newemail@gmail.com"
      click_button "Update"
      expect(current_path).to eq("/users/#{@user.id}")
      page.has_content?("Welcome, #{@user.name}")
    end
    scenario "destroys user and redirects to registration page" do
      click_link "Delete Account"
      expect(current_path).to eq("/users/new")
    end
  end
end
