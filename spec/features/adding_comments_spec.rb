require 'rails_helper'

RSpec.feature "Adding comments to Articles" do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    @article = Article.create(title: "Title", body: "Lorem ipsum.", user: @john)
  end
  
  scenario "signed in user writes on another's post" do
    login_as(@fred)
    visit "/"
    
    click_link(@article.title)
    
    fill_in "New Comment", with: "Nice article, John!"
    click_link("Add Comment")
    
    expect(page).to have_content("Comment successfully added.")
    expect(page).to have_content("Nice article, Jonh!")
    expect(current_path).to eq(article_path(@artice))
  end
end