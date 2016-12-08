require "rails_helper"

RSpec.feature "Creating articles" do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    @article = Article.create(title: "The First Article", body: "Lorem my ipsum, dawg.", user: @john)
  end
  
  scenario "with non user of article" do
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to_not have_link("Edit Article")
    expect(page).to_not have_link("Delete Article")
  end
  
  scenario "with non owner of article" do
    login_as(@fred)
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to_not have_link("Edit Article")
    expect(page).to_not have_link("Delete Article")
  end
  
  scenario "with owner of article" do
    login_as(@john)
    visit "/"
    
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
end