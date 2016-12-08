require 'rails_helper'

RSpec.feature "Deleting an article" do
  before do
    john = User.create!(email: "john@example.com", password: "password")
    login_as(john)
    @article = Article.create(title: "Delete Me", body: "This content shall be deleted!", user: john)
  end
  
  scenario "User deletes an article" do
    visit "/"
    
    click_link(@article.title)
    click_link("Delete Article")
    
    expect(page).to have_content("Article has successfully been deleted.")
    expect(current_path).to eq(articles_path)
  end
end