require 'rails_helper'

RSpec.feature "Signing up users" do
  scenario "with valid credentials" do
    visit "/"
    click_link "Log In"
    click_link "Sign up"
    fill_in "Email", with: "hello@world.com"
    fill_in "Password", with: "password"
    fill_in "Confirmation", with: "password"
    click_button "Sign up"
    
    expect(page).to have_content("You have signed up successfully.")
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "Log In"
    click_link "Sign up"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Confirmation", with: ""
    click_button "Sign up"
    
    expect(page).to have_content("errors prohibited")
  end
end