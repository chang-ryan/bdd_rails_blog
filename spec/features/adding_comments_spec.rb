require 'rails_helper'

RSpec.feature "Adding comments to article" do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    @article = @john.articles.build(title: "A New Title", body: "Lorem sum ipsum.")
    @article.save
  end
  
  scenario "signed in user writes a comment" do
    login_as(@fred)
    
    visit "/"
    
    click_link "A New Title"
    fill_in "New Comment", with: "What a lovely article!"
    click_button "Add Comment"
    
    expect(page).to have_content("Comment successfully added.")
    expect(page).to have_content("What a lovely article!")
    expect(page.current_path).to eq(article_path(@article))
  end
end