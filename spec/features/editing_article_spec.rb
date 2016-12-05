require 'rails_helper'

RSpec.describe "Editing an article" do
  before do
    @article = Article.create(title: "Hello, world.", body: "Ipsum lorem, hello.")
  end
  
  scenario "User updates an article" do
    visit "/"
    
    click_link @article.title
    click_link "Edit Article"
    
    fill_in "Title", with: "A New Title"
    fill_in "Body", with: "Lorem ipsum, bye."
    
    click_button "Update"
    
    expect(page).to have_content("Article has been successfully updated.")
    expect(page.current_path).to eq(article_path(@article))
  end
  
  scenario "User fails to update article" do
    visit "/"
    
    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: "Lorem ipsum, bye."
    
    click_button "Update"
    
    expect(page).to have_content("Article has not been updated.")
    expect(page.current_path).to eq(article_path(@article))
  end
end