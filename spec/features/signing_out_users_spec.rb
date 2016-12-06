require 'rails_helper'

RSpec.feature "Users signin" do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    
    visit "/"
    click_link "Log In"
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
    click_button "Log in"
  end
  
  scenario "sign user out" do
    visit "/"
    
    click_link "Log Out"
    
    expect(page).to have_content("Signed out successfully.")
    expect(page).to_not have_link("Log Out")
    expect(page).to have_link("Log In")
  end
  
end